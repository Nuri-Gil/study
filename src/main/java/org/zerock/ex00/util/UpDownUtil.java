package org.zerock.ex00.util;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

@Component // 스프링에서 컴포넌트로 읽을 수 있도록 -> root-context 설정 필요!
@Log4j2 // 로그 출력용
public class UpDownUtil {

    private final String UPLOAD = "C:\\upload";

    public void upload(MultipartFile[] files) {
        // 업로드 하는 파일이 없다면
        if (files == null || files.length == 0) {
            return;
        }
        for (MultipartFile file : files) {
            if (file.getSize() == 0) {
                continue;
            }
            // 파일 업로드 처리
            String fileName = file.getOriginalFilename();
            String uuid = UUID.randomUUID().toString();

            String saveFileName = uuid + "_" + fileName;

            try (
                    InputStream in = file.getInputStream();
                    OutputStream out = new FileOutputStream(UPLOAD+ File.separator+saveFileName)
            ) {
                FileCopyUtils.copy(in, out);
            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
    }
}
