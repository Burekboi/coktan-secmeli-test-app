package com.ders.bm470.service;

import com.ders.bm470.model.Choice;
import com.ders.bm470.model.Question;
import com.ders.bm470.repository.ChoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ders.bm470.service.QuestionService;

import java.util.List;

@Service
public class ChoiceServiceImpl implements ChoiceService {

    private final ChoiceRepository choiceRepo;
    private  QuestionService questionService;

    @Autowired
    public ChoiceServiceImpl(ChoiceRepository choiceRepo, QuestionService questionService) {
        this.choiceRepo = choiceRepo;
        this.questionService = questionService;
    }

    @Override
    @Transactional
    public Choice saveChoice(Choice choice) {
        if (choice.isCorrect()) {
            Question question = choice.getQuestion();
            if (question == null || question.getId() == null) {
                throw new IllegalArgumentException("Şık bir soruya bağlı olmalıdır.");
            }

            // Veritabanından güvenli şekilde al
            Question existingQuestion = questionService.getQuestionById(question.getId());

            long correctCount = existingQuestion.getChoices().stream()
                    .filter(Choice::isCorrect)
                    .count();

            if (correctCount >= 1) {
                throw new IllegalArgumentException("Bu soruya ait zaten bir doğru şık var!");
            }
        }

        return choiceRepo.save(choice);
    }


    @Override
    public Choice getChoiceById(Long id) {
        return choiceRepo.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public void deleteChoiceById(Long id) {
        choiceRepo.deleteById(id);
    }

    @Override
    public List<Choice> getAllChoices() {
        return choiceRepo.findAll();
    }
}
