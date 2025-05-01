package com.ders.bm470.service;

import com.ders.bm470.model.Choice;
import com.ders.bm470.repository.ChoiceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ChoiceServiceImpl implements ChoiceService {

    private final ChoiceRepository choiceRepo;

    @Autowired
    public ChoiceServiceImpl(ChoiceRepository choiceRepo) {
        this.choiceRepo = choiceRepo;
    }

    @Override
    @Transactional
    public Choice saveChoice(Choice choice) {
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
