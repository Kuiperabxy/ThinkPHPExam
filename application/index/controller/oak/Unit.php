<?php

namespace app\index\controller\oak;

abstract class Unit
{
    private $depth;

    abstract public function bombardStrength(): int;
    public function removeUnit(Unit $unit)
    {
        throw new \Exception(get_class($this) . "是叶子对象!");
    }
    public function addUnit(Unit $unit)
    {
        throw new \Exception(get_class($this) . "是叶子对象!");
    }

    public function getCompoiste()
    {
        return null;
    }

    public function textDump($num = 0): string
    {
        $txtout = "";
        $pad = 4 * $num;
        $txtout .= sprintf("%{$pad}", "");
        $txtout .= get_class($this) . ":";
        $txtout .= "bombard:" . $this->bombardStrength() . "<br/>";
    }
    public function accept(Armyvisitor $armyvisitor)
    {
        $refthis = new \ReflectionClass(get_class($this));
        $method = "visit" . $refthis->getShortName();
        $armyvisitor->$method($this);
    }

    public function setDepth($depth)
    {
        $this->depth = $depth;
    }

    public function getDepth()
    {
        return $this->depth;
    }
}
