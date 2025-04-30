// src/main/java/com/ders/bm470/service/QuestionService.java
package com.ders.bm470.service;

import com.ders.bm470.model.Question;
import java.util.List;

public interface QuestionService {
    Question saveQuestion(Question question);
    List<Question> getAllQuestions();
    // vs. ihtiyaç varsa...
}
