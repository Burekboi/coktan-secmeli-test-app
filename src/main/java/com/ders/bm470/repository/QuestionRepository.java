package com.ders.bm470.repository;

import com.ders.bm470.model.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Long> {
    // Gerekirse soru özel sorguları ekleriz
}
