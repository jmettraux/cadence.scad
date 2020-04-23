
// sublist
//
function _sl(list, from=0, to) =
  let(end = (to == undef ? len(list) - 1 : to))
  [ for ( i = [from:end]) list[i] ];

function _normalize_angle(a) =
  ((a >= 0 && a <= 360) ? a : _normalize_angle(a + (a < 0 ? 360 : -360)));

// pineapple slice
//
module paslice(radius, depth, slice=45, radius1=0) {

  s = _normalize_angle(slice);

  r = radius;

  if (s > 0) difference() {

    cylinder(depth, r=radius);

    translate([ 0, 0, -0.1 ]) cylinder(depth * 1.1, r=radius1);

    if (s != 360) {

      pas = [
        [ 0, r ], [ 0, 0 ] ];
      pbs = [
        [ r, r ], [ r, 0 ], [ r, -r ], [ 0, -r ], [ -r, -r ], [ -r, 0 ],
        [ -r, r ] ];

      t = tan(s);
      tx = t * r;
      ty = r / t;

      translate([ 0, 0, -0.1 ]) linear_extrude(depth + 0.2)
        if (s <= 45) polygon(concat(pas, [ [ tx, r ] ], pbs));
        else if (s <= 135) polygon(concat(pas, [ [ r, ty ] ], _sl(pbs, 2)));
        else if (s <= 225) polygon(concat(pas, [ [ -tx, -r ] ], _sl(pbs, 4)));
        else if (s <= 315) polygon(concat(pas, [ [ -r, -ty ] ], _sl(pbs, 6)));
        else if (s < 360) polygon(concat(pas, [ [ tx, r ] ]));
    }
  }
}

