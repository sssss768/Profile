package com.sean.assignment.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Scenery {
    private String name;
    private String address;
    private String description;
    private String img;
    private String email;
}
