<?php

namespace Controller;

class InformationController extends Controller
{
    public function index(): Result
    {
        return view('information.index')->withTitle('Information');
    }
}
