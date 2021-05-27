<?php

namespace app\index\controller\oak;

abstract class Armyvisitor
{
    abstract public function visit(Unit $node);

    public function visitArcher(Archer $node)
    {
        $this->visit($node);
    }

    public function visitLaser(Laser $node)
    {
        $this->visit($node);
    }

    public function visitTroop(Troop $node)
    {
        $this->visit($node);
    }

    public function visitArmy(Army $node)
    {
        $this->visit($node);
    }
}
