package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;

import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.TagsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class TagsController {

	private final TagsService ts;
	
}