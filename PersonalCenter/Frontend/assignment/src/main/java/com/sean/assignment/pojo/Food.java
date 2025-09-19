package com.sean.assignment.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class Food {
    private String name;
    private String material;
    private String description;
    private String img;
    private String email;
}

