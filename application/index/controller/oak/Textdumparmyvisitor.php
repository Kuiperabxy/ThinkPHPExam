<?php

namespace app\index\controller\oak;

class Textdumparmyvisitor extends Armyvisitor
{
    private $text = "";

    public function visit(Unit $node)
    {
        $txt = "";
        $pad = 4 * $node->getDepth();
        $txt .= sprintf("%{$pad}s", "");
        $txt .= get_class($node) . ": ";
        $txt .= "bombard: " . $node->bombardStrength() . "<br/>";
        $this->text .= $txt;
    }

    public function getText()
    {
        return $this->text;
    }
}
