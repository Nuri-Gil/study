package org.zerock.ex00.util;

import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.ex00.domain.AttachVO;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Component // 스프링에서 컴포넌트로 읽을 수 있도록 -> root-context 설정 필요!
@Log4j2 // 로그 출력용
public class UpDownUtil {

    private final String UPLOAD = "C:\\upload";

    // 업로드 되면 AttachVO 반환 되도록
    public List<AttachVO> upload(MultipartFile[] files) {

        // 업로드 하는 파일이 없다면
        if (files == null || files.length == 0) {
            return null;
        }

        // 첨부파일이 담길 AttachVO List 만들기
        List<AttachVO> list = new ArrayList<>();

        for (MultipartFile file : files) {
            if (file.getSize() == 0) {
                continue;
            }
            // 파일 업로드 처리
            String fileName = file.getOriginalFilename();
            String uuid = UUID.randomUUID().toString();

            String saveFileName = uuid + "_" + fileName;

            // 확장자 이름 "." 로 자르기 -> jpg, gif, png, bmp 등
            String suffix = fileName.substring(fileName.lastIndexOf(".") + 1);

            String regExp = "^(jpg|JPG|jpeg|JPEG|png|PNG|gif|GIF|bmp|BMP)";

            if (!suffix.matches(regExp)) {
                continue; // for 문이므로 continue
            }

            try (
                    InputStream in = file.getInputStream();
                    OutputStream out = new FileOutputStream(UPLOAD + File.separator + saveFileName)
            ) {
                FileCopyUtils.copy(in, out);
                // 섬네일 작업
                Thumbnails.of(new File(UPLOAD + File.separator + saveFileName))
                        .size(200, 200)
                        .toFile(UPLOAD + File.separator + "s_" + saveFileName);

                AttachVO attachVO = new AttachVO();
                attachVO.setUuid(uuid);
                attachVO.setFileName(fileName);
                list.add(attachVO);

            } catch (Exception e) {
                log.error(e.getMessage());
            }
        }
        return list;
    }
}
