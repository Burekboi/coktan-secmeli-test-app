package com.ders.bm470.controller;

import com.ders.bm470.model.Choice;
import com.ders.bm470.model.Question;
import com.ders.bm470.service.ChoiceService;
import com.ders.bm470.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/choices")
public class ChoiceController {

    private final ChoiceService choiceService;
    private final QuestionService questionService;

    @Autowired
    public ChoiceController(ChoiceService choiceService,
                            QuestionService questionService) {
        this.choiceService = choiceService;
        this.questionService = questionService;
    }

    // Şık oluşturma formunu göster
    @GetMapping("/create")
    public String showCreateForm(@RequestParam("questionId") Long questionId,
                                 Model model) {
        Choice choice = new Choice();
        model.addAttribute("choice", choice);
        Question q = questionService.getQuestionById(questionId);
        model.addAttribute("question", q);
        return "create_choice";  // create_choice.jsp
    }

    // Yeni şıkkı kaydet
    @PostMapping("/create/{questionId}")
    public String createChoice(@ModelAttribute("choice") Choice choice,
                               @PathVariable("questionId") Long questionId) {
        Question q = questionService.getQuestionById(questionId);
        choice.setQuestion(q);
        choiceService.saveChoice(choice);
        // Oluşturduğumuz şıkkın test detayına dön
        Long testId = q.getTest().getId();
        return "redirect:/tests/detail/" + testId;
    }

    // Şık düzenleme formunu göster
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") Long choiceId,
                               Model model) {
        Choice choice = choiceService.getChoiceById(choiceId);
        model.addAttribute("choice", choice);
        return "edit_choice";  // edit_choice.jsp
    }

    // Düzenlenen şıkkı kaydet
    @PostMapping("/edit/{id}")
    public String updateChoice(@PathVariable("id") Long choiceId,
                               @ModelAttribute("choice") Choice choice) {
        Choice existing = choiceService.getChoiceById(choiceId);
        existing.setText(choice.getText());
        existing.setCorrect(choice.isCorrect());
        choiceService.saveChoice(existing);
        // Düzenlenen şıkkın test detayına dön
        Long testId = existing.getQuestion().getTest().getId();
        return "redirect:/tests/detail/" + testId;
    }

    // Şık silme işlemi
    @GetMapping("/delete/{id}")
    public String deleteChoice(@PathVariable("id") Long choiceId) {
        Choice c = choiceService.getChoiceById(choiceId);
        Long testId = c.getQuestion().getTest().getId();
        choiceService.deleteChoiceById(choiceId);
        return "redirect:/tests/detail/" + testId;
    }
}
