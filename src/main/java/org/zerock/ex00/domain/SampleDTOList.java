package org.zerock.ex00.domain;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class SampleDTOList {
    // SampleDTO 인스턴스를 여러개 넣을 수 있는 List
    private List<SampleDTO> list = new ArrayList<>();
}
