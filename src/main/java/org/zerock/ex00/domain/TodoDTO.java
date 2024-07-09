package org.zerock.ex00.domain;

import lombok.Data;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@ToString
public class TodoDTO {

    private String title;

    @DateTimeFormat(pattern = "dd-MM-yyyy")
    private Date dueDate;
}
