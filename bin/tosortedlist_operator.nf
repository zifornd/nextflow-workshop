Channel
    .of( 3, 2, 1, 4 )
    .toSortedList()
    .subscribe onNext: { println it }, onComplete: { println 'Done' }