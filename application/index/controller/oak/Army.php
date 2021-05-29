<?php

namespace app\index\controller\oak;

class Army extends Composite
{
    public function bombardStrength(): int
    {
        $strength = 0;

        foreach ($this->getUnits() as $unit) {
            $strength += $unit->bombardStrength();
        }

        return $strength;
    }
}
