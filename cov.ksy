meta:
  id: cov
  file-extension: cov
  endian: le
seq:
  - id: magic
    contents: "IBEX COVERING FILE \0"
  - id: formatlevel
    type: s4
  - id: formatid
    type: formatarray(formatlevel)
  - id: formatversion
    type: formatarray(formatlevel)
  - id: n
    type: s4
  - id: covlist
    type: covlist
    if: formatlevel >= 1
  - id: coviulist
    type: coviulist
    if: formatlevel >= 2
  - id: covibulist
    type: covibulist
    if: formatlevel >= 3
  - id: covmanifold
    type: covmanifold
    if: formatlevel >= 4
  - id: covsolverdata
    type: covsolverdata
    if: formatlevel >= 5
types:
  formatarray:
    params:
      - id: level
        type: s4
    seq:
      - id: cov
        type: s4
      - id: list
        type: s4
        if: level >= 1
      - id: iulist
        type: s4
        if: level >= 2
      - id: ibulist
        type: s4
        if: level >= 3
      - id: manifold
        type: s4
        if: level >= 4
      - id: solverdata
        type: s4
        if: level >= 5
  interval:
    seq:
      - id: lb
        type: f8
      - id: ub
        type: f8
  box:
    seq:
      - id: box
        type: interval
        repeat: expr
        repeat-expr: _root.n
  covlist:
    seq:
      - id: box_count
        type: s4
      - id: boxes
        type: box
        repeat: expr
        repeat-expr: box_count
  coviulist:
    seq:
      - id: inner_count
        type: s4
      - id: inner_indices
        type: s4
        repeat: expr
        repeat-expr: inner_count
  
  covibulist:
    seq:
      - id: boundary_type
        type: s4
        enum: ibu_boundary
      - id: boundary_count
        type: s4
      - id: boundary_indices
        type: s4
        repeat: expr
        repeat-expr: boundary_count
        
  covsolverdata:
    seq:
      - id: var_names
        type: strz
        encoding: ascii
        repeat: expr
        repeat-expr: _root.n
      - id: status
        type: s4
        enum: solver_status
      - id: time
        type: f8
      - id: cells
        type: s4
      - id: pending_count
        type: s4
      - id: pending_boxes
        type: s4
        repeat: expr
        repeat-expr: pending_count
  
  covmanifold:
    seq:
      - id: eqs
        type: s4
      - id: ineqs
        type: s4
      - id: boundary_type
        type: s4
        enum: monifold_boundary
      - id: solution_count
        type: s4
        if: eqs > 0
      - id: solutions
        type: solution
        repeat: expr
        repeat-expr: solution_count
        if: eqs > 0
      - id: boundary_count
        type: s4
      - id: boundary_boxes
        type: boundary_box
        repeat: expr
        repeat-expr: boundary_count
      
    types:
      solution:
        seq:
          - id: index
            type: s4
          - id: proof_params
            type: s4
            repeat: expr
            repeat-expr: _root.n - _parent.eqs
            if: _parent.eqs < _root.n
          - id: unicity_box
            type: box
      boundary_box:
        seq:
          - id: index
            type: s4
          - id: param_proof_indices
            type: s4
            repeat: expr
            repeat-expr: _root.n - _parent.eqs
            if: _parent.eqs > 0 and _parent.eqs < _root.n

enums:
  solver_status:
    0: complete_feasible
    1: complete_infeasible
    2: incomplete_minimal_width
    3: incomplete_timeout
    4: incomplete_buffer_overflow
  ibu_boundary:
    0: contains_at_least_one
    1: one_inner_one_outer
  monifold_boundary:
    0: only_eqs
    1: eqs_and_lic
    2: half_ball