
package org.zerock.ex00.domain;

import lombok.Data;

@Data
public class AttachVO {

    private Long ano;
    private Long bno;
    private String uuid;
    private String fileName;

    // uuid 와 fileName 을 하나로 합치도록
    public String getFullName() {
        if (ano == null) {
            return null;
        }
        return uuid + "_" + fileName;
    }

}
