package org.zerock.ex00.domain;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ReplyVO {
    private Long rno;
    private Long bno;
    private String replyText;
    private String replyer;

    @JsonFormat(pattern = "yyyy/MM/dd HH:mm")
    private LocalDateTime regDate;
    @JsonFormat(pattern = "yyyy/MM/dd HH:mm")
    private LocalDateTime updateDate;
}
