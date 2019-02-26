package com.coffeeshop.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.coffeeshop.domain.BoardAttachVO;
import com.coffeeshop.domain.BoardVO;
import com.coffeeshop.domain.Criteria;
import com.coffeeshop.domain.PageDTO;
import com.coffeeshop.service.BoardService;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/")
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list");
		model.addAttribute("list", service.getList(cri));
		int total = service.getTotal(cri);
		log.info("total: " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@GetMapping("/register")
	public void register() {

	}

	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr, MultipartFile[] uploadFile) {

	    String uploadFolder = "C:\\upload\\boardAttach";

		/*log.info("==============");
		log.info("register: " + board);
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}*/

		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path : "+ uploadPath);

		if(!uploadPath.exists()){
		    uploadPath.mkdirs();
        }

		List<BoardAttachVO> attachVOList = new ArrayList<>();

        for(MultipartFile file : uploadFile){
            log.info("=================");
            log.info("file Name : " + file.getOriginalFilename());

            BoardAttachVO boardAttachVO = new BoardAttachVO();

            String uploadOriginFileName = file.getOriginalFilename();

            //IE
            uploadOriginFileName = uploadOriginFileName.substring(uploadOriginFileName.lastIndexOf("\\")+1);

            UUID uuid = UUID.randomUUID();
            String uploadFileName = uuid.toString() + "_" + uploadOriginFileName;

            File saveFile = new File(uploadPath, uploadFileName);
            try{
                file.transferTo(saveFile);

                boardAttachVO.setFileName(uploadOriginFileName);
                boardAttachVO.setUploadPath(uploadPath.toString());
                boardAttachVO.setFileType(true);
                boardAttachVO.setUuid(uuid.toString());

                attachVOList.add(boardAttachVO);

            }catch (Exception e){
                log.error(e.getMessage());
            }

        }

        board.setAttachList(attachVOList);
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());



		return "redirect:/board/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
	}


	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("modify: " + board);

		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}

		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/board/list";
	}


	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, String writer) {
		log.info("remove: " + bno);

		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		log.info("getAttachList" + bno);
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(bno), HttpStatus.OK);
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent")String userAgent, String fileName){

		log.info("download file: " + fileName);

		Resource resource = new FileSystemResource(fileName);

		if(resource.exists() == false) {
			log.info("not found");
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}

		log.info("resource: " + resource);

		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);

		HttpHeaders headers = new HttpHeaders();

		try {

			String downloadName = null;

			if(userAgent.contains("Trident")) {
				log.info("IE browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+"," ");

			} else if(userAgent.contains("Edge")) {
				log.info("Edge browser");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			}else {
				log.info("Chrome browser");
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}

			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);

	}


	private String getFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();

        String str = sdf.format(date);

        return str.replace("-", File.separator);

    }

}
