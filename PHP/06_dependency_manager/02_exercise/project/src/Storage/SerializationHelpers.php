<?php

namespace Storage;

use Concept\Distinguishable;

trait SerializationHelpers
{
    public static function deserializeAsDistinguishable(string $contents): Distinguishable
    {
        $object = unserialize($contents);
        if (!$object instanceof Distinguishable) {
            exit("Deserialized object is not a " . Distinguishable::class . "!");
        }
        return $object;
    }

    /**
     * @param string[] $contentsArray
     * @return Distinguishable[]
     */
    public static function deserializeAsDistinguishableArray(array $contentsArray): array
    {
        $result = [];

        foreach ($contentsArray as $contents) {
            $result[] = self::deserializeAsDistinguishable($contents);
        }

        return $result;
    }
}
