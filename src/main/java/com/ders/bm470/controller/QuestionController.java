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

    // Soru oluşturma formu
    @GetMapping("/create")
    public String showCreateForm(@RequestParam(value = "testId", required = false) Long testId,
                                 Model model) {
        Question question = new Question();
        model.addAttribute("question", question);
        model.addAttribute("tests", testService.getTestById(testId));
        return "create_question";
    }

    // Yeni soruyu kaydet
    @PostMapping("/create/{testId}")
    public String createQuestion(@ModelAttribute("question") Question question,
                                 @PathVariable("testId") Long testId) {
        Test t = testService.getTestById(testId);
        question.setTest(t);
        questionService.saveQuestion(question);
        return "redirect:/tests/detail/" + t.getId();
    }

    // Soru düzenleme formu
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long questionId,
                               Model model) {
        Question question = questionService.getQuestionById(questionId);
        model.addAttribute("question", question);
        // Aynı create formundaki gibi tests attribute’u
        Test t = testService.getTestById(question.getTest().getId());
        model.addAttribute("tests", testService.getTestById(question.getTest().getId()));
        return "redirect:/tests/detail/" + t.getId();
    }

    @PostMapping("/edit/{id}")
    public String updateQuestion(@PathVariable("id") Long questionId,
                                 @RequestParam("text") String newText) {
        Question existing = questionService.getQuestionById(questionId);
        if (existing == null) {
            return "redirect:/home";  // veya 404 sayfası
        }
        existing.setText(newText);
        questionService.saveQuestion(existing);
        // ait olduğu testin detay sayfasına dön
        Long testId = existing.getTest().getId();
        return "redirect:/tests/detail/" + testId;
    }

    // Soru silme işlemi
    @GetMapping("/delete/{id}")
    public String deleteQuestion(@PathVariable("id") Long questionId) {
        Question question = questionService.getQuestionById(questionId);
        Long testId = question.getTest().getId();
        questionService.deleteQuestionById(questionId);
        return "redirect:/tests/detail/" + testId;
    }
}
