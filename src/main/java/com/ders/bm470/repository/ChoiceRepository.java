package com.ders.bm470.repository;

import com.ders.bm470.model.Choice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChoiceRepository extends JpaRepository<Choice, Long> {
    // Gerekirse şık özel sorguları ekleriz
}
