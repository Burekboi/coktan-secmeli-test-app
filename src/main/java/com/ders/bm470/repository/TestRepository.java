package com.ders.bm470.repository;

import com.ders.bm470.model.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TestRepository extends JpaRepository<Test, Long> {
    // Burada ekstra özel query gerekirse ekleyeceğiz
}
