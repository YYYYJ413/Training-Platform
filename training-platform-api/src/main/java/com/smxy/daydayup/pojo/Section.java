package com.smxy.daydayup.pojo;

import lombok.*;
import net.sf.jsqlparser.schema.Table;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@EnableJpaAuditing
public class Section {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int chapterId;

    @Column(name = "course_id", nullable = false)
    private int courseId;

    @Column(name = "chapter_name", length = 50, nullable = false)
    private String chapterName;

    @Column(name = "chapter_belong", nullable = false)
    private int chapterBelong;

    @Column(name = "chapter_order")
    private int chapterOrder;

    @Column(name = "chapter_content", length = 50)
    private String chapterContent;

    @Column(name = "time_create", nullable = false)
    private LocalDateTime timeCreate;

    @Column(name = "time_modify")
    @LastModifiedDate
    private LocalDateTime timeModify;
}

