package com.ders.bm470.repository;

import com.ders.bm470.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByUsername(String username);
    boolean existsByUsername(String username);
}


//
//public interface TestResultRepository extends JpaRepository<TestResult, Long> {
//    List<TestResult> findByUser(User user);
//}
