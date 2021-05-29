<?php

namespace app\index\controller\oak;

abstract class Composite extends Unit
{
    private $units = [];
    private $depth;

    public function getCompoiste(): Composite
    {
        return $this;
    }

    public function addUnit(Unit $unit)
    {
        // if (in_array($unit, $this->units, true)) {
        //     return;
        // }
        // $this->units[] = $unit;
        foreach ($this->units as $thisUnit) {
            if ($unit === $thisUnit) {
                return;
            }
        }

        $unit->setDepth($this->depth + 1);
        $this->units[] = $unit;
    }

    public function removeUnit(Unit $unit)
    {
        $idx = array_search($unit, $this->units, true);

        if (is_int($idx)) {
            array_splice($this->units, $idx, 1, []);
        }
    }

    public function getUnits(): array
    {
        return $this->units;
    }

    public function textDump($num = 0): string
    {
        $txtout = parent::textDump($num);

        foreach ($this->units as $unit) {
            $txtout .= $unit->textDump($num + 1);
        }

        return $txtout;
    }

    public function accept(Armyvisitor $armyvisitor)
    {
        parent::accept($armyvisitor);

        foreach ($this->units as $thisUnit) {
            $thisUnit->accept($armyvisitor);
        }
    }
}
