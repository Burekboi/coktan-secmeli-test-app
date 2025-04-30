// src/main/java/com/ders/bm470/service/QuestionServiceImpl.java
package com.ders.bm470.service;

import com.ders.bm470.model.Question;
import com.ders.bm470.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionRepository questionRepo;

    @Autowired
    public QuestionServiceImpl(QuestionRepository questionRepo) {
        this.questionRepo = questionRepo;
    }

    @Override
    @Transactional
    public Question saveQuestion(Question question) {
        return questionRepo.save(question);
    }

    @Override
    public List<Question> getAllQuestions() {
        return questionRepo.findAll();
    }
}
