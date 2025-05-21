package com.ders.bm470.repository;

import com.ders.bm470.model.User;
import com.ders.bm470.model.TestResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

@Repository
public interface TestResultRepository extends JpaRepository<TestResult, Long> {
    List<TestResult> findByUser(User user);
    Optional<TestResult> findTopByTest_IdAndUser_UsernameOrderByCreatedAtDesc(Long testId, String username);

}
