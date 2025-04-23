package com.smxy.daydayup.util.result;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class PageResult<T> implements Serializable {
    private List<T> list;
    private long total;
    private long pages;
    private long currentPage;

    public static<T> PageResult<T> setResult(IPage<T> page) {
        PageResult<T> result = new PageResult();
        result.setList(page.getRecords());
        result.setPages(page.getPages());
        result.setTotal(page.getTotal());
        result.setCurrentPage(page.getCurrent());
        return result;
    }

}
