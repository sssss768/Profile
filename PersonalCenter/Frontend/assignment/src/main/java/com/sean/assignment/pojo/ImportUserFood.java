package com.sean.assignment.pojo;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ImportUserFood {
    private MultipartFile image;
    private Food food;
}
