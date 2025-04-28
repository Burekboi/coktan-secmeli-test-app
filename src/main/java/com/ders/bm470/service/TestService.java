package com.ders.bm470.service;

import com.ders.bm470.model.Test;

import java.util.List;

public interface TestService {
    Test saveTest(Test test);
    List<Test> getAllTests();
    Test getTestById(Long id);
    void deleteTest(Long id);
}
