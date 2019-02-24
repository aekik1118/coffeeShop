package com.coffeeshop.controller;

import com.coffeeshop.domain.ProductAttachDTO;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@Log4j
public class ProductUploadController {


    @PostMapping(value = "/productUpload" , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ProductAttachDTO>> productUpload(MultipartFile[] uploadFile) {
        log.info("product file upload........");

        List<ProductAttachDTO> list = new ArrayList<>();
        String uploadFolder = "C://productupload";

        File uploadPath = new File(uploadFolder, "");

        if(uploadPath.exists() == false) uploadPath.mkdirs();

        for(MultipartFile multipartFile : uploadFile) {
            ProductAttachDTO attachDTO = new ProductAttachDTO();

            log.info("--------------------------------------");
            log.info("Upload File Name : " + multipartFile.getOriginalFilename());
            log.info("upload File Size : " + multipartFile.getSize());
            log.info("--------------------------------------");

            String uploadFileName = multipartFile.getOriginalFilename();
            log.info("upload file name : " + uploadFileName);
            attachDTO.setFileName(uploadFileName);

            UUID uuid = UUID.randomUUID();
            uploadFileName = uuid.toString() + "_" + uploadFileName;
            attachDTO.setUuid(uuid.toString());

            try{
                File saveFile = new File(uploadPath, uploadFileName);
                multipartFile.transferTo(saveFile);

                attachDTO.setUploadPath(uploadFolder);

                FileOutputStream thumbnail = new FileOutputStream(new File(uploadFolder, "s_" + uploadFileName));
                Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                thumbnail.close();

                list.add(attachDTO);
            } catch (Exception e) {
                log.error(e.getMessage());
            }

        }

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping("/productFileDelete")
    public ResponseEntity<String> deleteFile (String fileName) {
        log.info("fileName : " + fileName);

        File file;

        try {
            file = new File(URLDecoder.decode(fileName, "UTF-8"));
            log.info("file : " + file);
            file.delete();

            String largeFileName = file.getAbsolutePath().replace("s_", "");
            log.info("largeFileName : " + largeFileName);

            file = new File(largeFileName);

            file.delete();

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();

            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<String>("delete", HttpStatus.OK);
    }
}
