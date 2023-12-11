Channel.of( 1, 2, 3, 4, 5 )
    .multiMap {
        small: it
        large: it * 10
    }
    .set { numbers }

numbers.small | view { num -> "Small: $num"}
numbers.large | view { num -> "Large: $num"}
