<?php

namespace app\index\controller\strategy;

class Marklogicmarker extends Marker
{
    private $engine;

    public function __construct(string $test)
    {
        parent::__construct($test);
        $this->engine = new Parse($test);
    }

    public function mark(string $reponse): bool
    {
        return $this->engine->evaluate($reponse);
    }
    public static function index()
    {
        return 11111;
    }
}
