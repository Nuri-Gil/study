package org.zerock.ex00.mappers;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
    @Select("SELECT now()")
    String getTime();
}
