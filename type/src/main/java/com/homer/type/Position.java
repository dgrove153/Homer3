package com.homer.type;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.homer.util.EnumUtil;
import com.homer.util.core.IIntEnum;

import java.util.LinkedHashMap;

/**
 * Created by arigolub on 3/5/16.
 */
@SuppressWarnings("SpellCheckingInspection")
@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum Position implements IIntEnum<Position> {
    UTILITY(12, "U", null, null),
    MIDDLEINFIELD(10, "2B/SS", UTILITY, null),
    CORNERINFIELD(11, "1B/3B", UTILITY, null),
    PITCHER(1, "P", null, null),
    CATCHER(2, "C", UTILITY, null),
    FIRSTBASE(3, "1B", CORNERINFIELD, UTILITY),
    SECONDBASE(4, "2B", MIDDLEINFIELD, UTILITY),
    THIRDBASE(5, "3B", CORNERINFIELD, UTILITY),
    SHORTSTOP(6, "SS", MIDDLEINFIELD, UTILITY),
    OUTFIELD(7, "OF", UTILITY, null),
    DESIGNATEDHITTER(8, "DH", UTILITY, null),
    RELIEFPITCHER(9, "RP", null, null),
    DISABLIEDLIST(13, "DL", null, null),
    MINORLEAGUES(14, "MIN", null, null);

    private final int id;
    private final String name;
    @JsonIgnore
    private final Position grants1;
    @JsonIgnore
    private final Position grants2;

    private Position(int id, String name, Position grants1, Position grants2) {
        this.id = id;
        this.name = name;
        this.grants1 = grants1;
        this.grants2 = grants2;
    }

    @Override
    public int getId() {
        return id;
    }

    @Override
    public String getName() {
        return name;
    }

    @JsonIgnore
    public Position getGrants1() {
        return grants1;
    }

    @JsonIgnore
    public Position getGrants2() {
        return grants2;
    }

    @JsonCreator
    public static Position forValue(Object value) {
        Integer position;
        if (value instanceof LinkedHashMap) {
            position = (Integer)((LinkedHashMap)value).get("id");
        } else if (value instanceof String) {
            position = Integer.valueOf((String)value);
        } else {
            throw new IllegalArgumentException("Unknown object type for POSITION");
        }
        return EnumUtil.from(Position.class, position);
    }
}
