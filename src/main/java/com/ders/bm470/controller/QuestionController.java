// src/main/java/com/ders/bm470/controller/QuestionController.java
package com.ders.bm470.controller;

import com.ders.bm470.model.Question;
import com.ders.bm470.model.Test;
import com.ders.bm470.service.QuestionService;
import com.ders.bm470.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/questions")
public class QuestionController {

    private final QuestionService questionService;
    private final TestService testService;

    @Autowired
    public QuestionController(QuestionService questionService, TestService testService) {
        this.questionService = questionService;
        this.testService = testService;
    }

    @GetMapping("/create")
    public String showCreateForm(@RequestParam(value = "testId", required = false) Long testId,
                                 Model model) {
        // back-form
        Question question = new Question();
        model.addAttribute("question", question);
        model.addAttribute("tests", testService.getTestById(testId));
        return "create_question";
    }

    @PostMapping("/create/{testId}")
    public String createQuestion(@ModelAttribute("question") Question question,
                                 @PathVariable("testId") Long testId) {
        Test t = testService.getTestById(testId);
        question.setTest(t);
        questionService.saveQuestion(question);
        return "redirect:/tests/detail/" + t.getId();
    }
}
