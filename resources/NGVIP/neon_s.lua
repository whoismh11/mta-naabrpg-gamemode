local vehicles =
{
    [ 400 ] = true,
    [ 401 ] = true,
    [ 402 ] = true,
    [ 403 ] = true,
    [ 404 ] = true,
    [ 405 ] = true,
    [ 409 ] = true,
    [ 410 ] = true,
    [ 415 ] = true,
    [ 411 ] = true,
    [ 412 ] = true,
    [ 413 ] = true,
    [ 415 ] = true,
    [ 416 ] = true,
    [ 418 ] = true,
    [ 419 ] = true,
    [ 420 ] = true,
    [ 421 ] = true,
    [ 422 ] = true,
    [ 423 ] = true,
    [ 426 ] = true,
    [ 428 ] = true,
    [ 429 ] = true,
    [ 431 ] = true,
    [ 434 ] = true,
    [ 436 ] = true,
    [ 437 ] = true,
    [ 438 ] = true,
    [ 439 ] = true,
    [ 440 ] = true,
    [ 442 ] = true,
    [ 445 ] = true,
    [ 446 ] = true,
    [ 451 ] = true,
    [ 458 ] = true,
    [ 459 ] = true,
    [ 466 ] = true,
    [ 467 ] = true,
    [ 470 ] = true,
    [ 474 ] = true,
    [ 475 ] = true,
    [ 477 ] = true,
    [ 479 ] = true,
    [ 480 ] = true,
    [ 482 ] = true,
    [ 483 ] = true,
    [ 489 ] = true,
    [ 490 ] = true,
    [ 491 ] = true,
    [ 492 ] = true,
    [ 494 ] = true,
    [ 495 ] = true,
    [ 496 ] = true,
    [ 498 ] = true,
    [ 499 ] = true,
    [ 500 ] = true,
    [ 502 ] = true,
    [ 503 ] = true,
    [ 504 ] = true,
    [ 505 ] = true,
    [ 506 ] = true,
    [ 507 ] = true,
    [ 508 ] = true,
    [ 516 ] = true,
    [ 517 ] = true,
    [ 518 ] = true,
    [ 525 ] = true,
    [ 526 ] = true,
    [ 527 ] = true,
    [ 528 ] = true,
    [ 529 ] = true,
    [ 533 ] = true,
    [ 534 ] = true,
    [ 535 ] = true,
    [ 536 ] = true,
    [ 540 ] = true,
    [ 541 ] = true,
    [ 542 ] = true,
    [ 543 ] = true,
    [ 545 ] = true,
    [ 546 ] = true,
    [ 547 ] = true,
    [ 549 ] = true,
    [ 550 ] = true,
    [ 551 ] = true,
    [ 552 ] = true,
    [ 554 ] = true,
    [ 555 ] = true,
    [ 558 ] = true,
    [ 559 ] = true,
    [ 560 ] = true,
    [ 561 ] = true,
    [ 562 ] = true,
    [ 565 ] = true,
    [ 566 ] = true,
    [ 567 ] = true,
    [ 568 ] = true,
    [ 575 ] = true,
    [ 576 ] = true,
    [ 579 ] = true,
    [ 580 ] = true,
    [ 582 ] = true,
    [ 585 ] = true,
    [ 587 ] = true,
    [ 588 ] = true,
    [ 589 ] = true,
    [ 596 ] = true,
    [ 597 ] = true,
    [ 598 ] = true,
    [ 599 ] = true,
    [ 600 ] = true,
    [ 602 ] = true,
    [ 603 ] = true,
    [ 604 ] = true,
    [ 605 ] = true,
    [ 609 ] = true
}
 
function neons (theVehicle)
    local NeonType = getElementData(source, "neon")
    if not NeonType or ( NeonType == 0 ) then return end
            local x, y, z = getElementPosition ( theVehicle )
            if not x or not y or not z then return end
            local id = getElementModel ( theVehicle )
            if ( vehicles [ id ] ) then
                local neon = createObject ( NeonType, x, y, z )
                local neon1 = createObject ( NeonType, x, y, z )
                local neon2 = createObject ( NeonType, x, y, z )
                local neon3 = createObject ( NeonType, x, y, z )
                if ( id == 401 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.55 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.55 )
                elseif ( id == 411 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.25, -0.63, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.63, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.63 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.63 )
                elseif ( id == 416 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.55, -0.67, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.55, -0.73, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.7 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.7 )
                elseif ( id == 422 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.85, 0, -0.66 )
                    attachElements ( neon, theVehicle or source, -0.85, 0, -0.66 )
                elseif ( id == 429 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.51 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.51 )
                elseif ( id == 445 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.1, -0.55, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.55, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.55 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.55 )
                elseif ( id == 459 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.8, 0, -0.78 )
                    attachElements ( neon, theVehicle or source, -0.8, 0, -0.78 )
                elseif ( id == 498 ) or ( id == 609 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.65, -0.7, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.2, -0.7, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0, -0.7 )
                    attachElements ( neon, theVehicle or source, -1.1, 0, -0.7 )
                elseif ( id == 499 ) or ( id == 498 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.8, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.8, 0, -0.6 )
               elseif ( id == 504 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.1, -0.55, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.55, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.55)
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.55 )
               elseif ( id == 575 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.3, -0.38, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.38, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.38)
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.38 )
                elseif ( id == 535 ) or ( id == 536 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.1, -0.6, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.6, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.6 )
                elseif ( id == 496 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.85, 0, -0.5 )
                    attachElements ( neon, theVehicle or source, -0.85, 0, -0.5 )
                elseif ( id == 568 ) then
                    destroyElement(neon1)
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon, theVehicle or source, 0, 0.45, -0.42 )
                elseif ( id == 602 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.05, -0.6, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.6, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.6 )
                elseif ( id == 518 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.3, -0.5, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.5, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.15, -0.5 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.15, -0.5 )
                elseif ( id == 402 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 1, 0, -0.63 )
                    attachElements ( neon, theVehicle or source, -1, 0, -0.63 )
                elseif ( id == 541 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.45 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.45 )
                elseif ( id == 482 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.25, -0.82, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.82, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.05, -0.82 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.05, -0.82 )
                elseif ( id == 438 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.25, -0.72, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.72, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.72 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.72 )
                elseif ( id == 527 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.92, 0.15, -0.47 )
                    attachElements ( neon, theVehicle or source, -0.92, 0.15, -0.47 )
                elseif ( id == 483 ) then
                    attachElements ( neon3, theVehicle or source, 0.85, -0.48, -0.80 )
                    attachElements ( neon2, theVehicle or source, -0.85, -0.48, -0.80 )
                    attachElements ( neon1, theVehicle or source, 0.85, 0.3, -0.80 )
                    attachElements ( neon, theVehicle or source, -0.85, 0.3, -0.80 )
                elseif ( id == 431 ) or ( id == 437 ) then
                    attachElements ( neon3, theVehicle or source, 1.3, -0.7, -0.77 )
                    attachElements ( neon2, theVehicle or source, -1.3, -0.7, -0.77 )
                    attachElements ( neon1, theVehicle or source, 1.3, 1.8, -0.77 )
                    attachElements ( neon, theVehicle or source, -1.3, 1.8, -0.77 )
                elseif ( id == 415 ) or ( id == 542 ) or ( id == 466 ) or ( id == 604 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.1, -0.57, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.57, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.57 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.57 )
                elseif ( id == 589 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.43, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.92, 0.1, -0.43 )
                    attachElements ( neon, theVehicle or source, -0.92, 0.1, -0.43 )
                elseif ( id == 480 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.72, 0, -0.53 )
                    attachElements ( neon, theVehicle or source, -0.72, 0, -0.53 )
                elseif ( id == 507 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.3, -0.65, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.65, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0, -0.65 )
                    attachElements ( neon, theVehicle or source, -1.1, 0, -0.65 )
                elseif ( id == 562 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.95, 0.15, -0.48 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.15, -0.48 )
                elseif ( id == 419 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.61, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.97, 0.1, -0.61 )
                    attachElements ( neon, theVehicle or source, -0.97, 0.1, -0.61 )
                elseif ( id == 587 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.61, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.05, -0.05, -0.61 )
                    attachElements ( neon, theVehicle or source, -1.05, -0.05, -0.61 )
               elseif ( id == 490 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.5, -0.66, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.66, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0.1, -0.66 )
                    attachElements ( neon, theVehicle or source, -0.9, 0.1, -0.66 )
               elseif ( id == 528 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -0.95, -0.59, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0.15, -0.59 )
                    attachElements ( neon, theVehicle or source, -0.9, 0.15, -0.59 )
               elseif ( id == 533 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.93, 0, -0.51 )
                    attachElements ( neon, theVehicle or source, -0.93, 0, -0.51 )
               elseif ( id == 565 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.83, 0, -0.47 )
                    attachElements ( neon, theVehicle or source, -0.83, 0, -0.47 )
                elseif ( id == 526 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.93, 0, -0.61 )
                    attachElements ( neon, theVehicle or source, -0.93, 0, -0.61 )
               elseif ( id == 492 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.17, -0.5, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.17, -0.5, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.93, 0, -0.5 )
                    attachElements ( neon, theVehicle or source, -0.93, 0, -0.5 )
                elseif ( id == 588 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.6, -0.71, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.6, -0.71, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.4, 0, -0.71 )
                    attachElements ( neon, theVehicle or source, -1.4, 0, -0.71 )
                elseif ( id == 434 ) then
                    destroyElement(neon1)
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon, theVehicle or source, 0, 0.85, -0.83 )
                elseif ( id == 494 ) or ( id == 502 ) or ( id == 503 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.93, -0.07, -0.71 )
                    attachElements ( neon, theVehicle or source, -0.93, -0.07, -0.71 )
               elseif ( id == 579 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.55, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.96, 0.05, -0.55 )
                    attachElements ( neon, theVehicle or source, -0.96, 0.05, -0.55 )
               elseif ( id == 545 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.93, 0, -0.64 )
                    attachElements ( neon, theVehicle or source, -0.93, 0, -0.64 )
                elseif ( id == 546 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.15, -0.53, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.35, -0.53, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, -0.1, -0.53 )
                    attachElements ( neon, theVehicle or source, -1, -0.1, -0.53 )
                elseif ( id == 559 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.48 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.48 )
                elseif ( id == 508 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.3, -1, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.8, -1.07, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, -0.4, -1.07 )
                    attachElements ( neon, theVehicle or source, -1.1, -0.4, -1.07 )
                elseif ( id == 400 ) then
                    destroyElement(neon2)
                    destroyElement(neon3)
                    attachElements ( neon1, theVehicle or source, 0.8, 0, -0.73 )
                    attachElements ( neon, theVehicle or source, -0.8, 0, -0.73 )
                elseif ( id == 403 ) then
                    attachElements ( neon3, theVehicle or source, 0.7, 0.75, -1.2 )
                    attachElements ( neon2, theVehicle or source, -0.7, 0.75, -1.2 )
                    attachElements ( neon1, theVehicle or source, 0.7, 1.75, -1.2 )
                    attachElements ( neon, theVehicle or source, -0.7, 1.75, -1.2 )
               elseif ( id == 517 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -0.98, -0.62, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.1, -0.62 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.1, -0.62 )
               elseif ( id == 410 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.91, 0, -0.45 )
                    attachElements ( neon, theVehicle or source, -0.91, 0, -0.45 )
                elseif ( id == 551 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.35, -0.6, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.6, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.98, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.98, 0, -0.6 )
                elseif ( id == 500 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.7, 0.2, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.7, 0.2, -0.6 )
                elseif ( id == 418 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.35, -0.89, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.2, -0.89, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.98, 0, -0.89 )
                    attachElements ( neon, theVehicle or source, -0.98, 0, -0.89 )
                elseif ( id == 423 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 1, 0.2, -0.75 )
                    attachElements ( neon, theVehicle or source, -1, 0.2, -0.75 )
                elseif ( id == 516 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.65, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, 0.2, -0.65 )
                    attachElements ( neon, theVehicle or source, -1, 0.2, -0.65 )
                elseif ( id == 582 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.35, -0.78, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -2.7, -0.75, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, -0.15, -0.78 )
                    attachElements ( neon, theVehicle or source, -1, -0.15, -0.78 )
                elseif ( id == 467 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.18, -0.55, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.99, 0.15, -0.55 )
                    attachElements ( neon, theVehicle or source, -0.99, 0.15, -0.55 )
                elseif ( id == 470 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.27, -0.42, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0.02, -0.42 )
                    attachElements ( neon, theVehicle or source, -1.1, 0.02, -0.42 )
                elseif ( id == 404 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.83, 0, -0.48 )
                    attachElements ( neon, theVehicle or source, -0.83, 0, -0.48 )
                elseif ( id == 603 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.15, -0.7, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.13, -0.7, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.97, 0, -0.7 )
                    attachElements ( neon, theVehicle or source, -0.97, 0, -0.7 )
                elseif ( id == 600 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.27, -0.56, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -2, -0.43, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, 0.15, -0.56 )
                    attachElements ( neon, theVehicle or source, -1, 0.15, -0.56 )
                elseif ( id == 596 ) or ( id == 597 ) or ( id == 426 ) or ( id == 420 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.53, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, 0.2, -0.53 )
                    attachElements ( neon, theVehicle or source, -1, 0.2, -0.53 )
                elseif ( id == 598 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.48, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.97, 0.1, -0.48 )
                    attachElements ( neon, theVehicle or source, -0.97, 0.1, -0.48 )
                elseif ( id == 599 ) or ( id == 489 ) or ( id == 505 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.85, 0.1, -0.69 )
                    attachElements ( neon, theVehicle or source, -0.85, 0.1, -0.69 )
                elseif ( id == 413 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.77, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0.1, -0.77 )
                    attachElements ( neon, theVehicle or source, -0.9, 0.1, -0.77 )
                elseif ( id == 436 ) or ( id == 547 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.87, 0, -0.53 )
                    attachElements ( neon, theVehicle or source, -0.87, 0, -0.53 )
                elseif ( id == 479 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.27, -0.51, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -2.1, -0.46, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, 0.15, -0.51 )
                    attachElements ( neon, theVehicle or source, -1, 0.15, -0.51 )
                elseif ( id == 534 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.6, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.98, 0.3, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.98, 0.3, -0.6 )
               elseif ( id == 442 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.55, -0.66, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.45, -0.66, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.05, 0.15, -0.66 )
                    attachElements ( neon, theVehicle or source, -1.05, 0.15, -0.66 )
               elseif ( id == 440 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.95, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.15, -0.95 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.15, -0.95 )
               elseif ( id == 475 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.91, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.91, 0, -0.6 )
               elseif ( id == 605 ) or ( id == 543 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -2.05, -0.47, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, 0, -0.47 )
                    attachElements ( neon, theVehicle or source, -1, 0, -0.47 )
               elseif ( id == 495 ) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.9, 0.15, -0.83 )
                    attachElements ( neon, theVehicle or source, -0.9, 0.15, -0.83 )
                elseif ( id == 567 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.55, -0.65, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.65, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0.25, -0.65 )
                    attachElements ( neon, theVehicle or source, -1.1, 0.25, -0.65 )
                elseif ( id == 428 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.35, -0.8, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.8, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.15, 0.1, -0.8 )
                    attachElements ( neon, theVehicle or source, -1.15, 0.1, -0.8 )
                elseif ( id == 405 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.67, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.1, -0.67 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.1, -0.67 )
                elseif ( id == 458 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.2, -0.65, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.2, -0.65, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.65 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.65 )
                elseif ( id == 580 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.1, -0.53, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.1, -0.53, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.15, 0, -0.53 )
                    attachElements ( neon, theVehicle or source, -1.15, 0, -0.53 )
                elseif ( id == 439 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.68, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0.15, -0.68 )
                    attachElements ( neon, theVehicle or source, -0.9, 0.15, -0.68 )
                elseif ( id == 561 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.2, -0.63, 0, 0, 90 )
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.63 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.63 )
                elseif ( id == 409 ) then
                    attachElements ( neon3, theVehicle or source, 0.9, 1, -0.53 )
                    attachElements ( neon2, theVehicle or source, -0.9, 1, -0.53 )
                    attachElements ( neon1, theVehicle or source, 0.9, -1, -0.53 )
                    attachElements ( neon, theVehicle or source, -0.9, -1, -0.53 )
                elseif ( id == 560 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.15, -0.49, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -1.05, -0.49, 0, 0, 90  )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.05, -0.49 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.05, -0.49 )
                elseif ( id == 550 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.2, -0.65, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.65, 0, 0, 90  )
                    attachElements ( neon1, theVehicle or source, 1.05, 0, -0.65 )
                    attachElements ( neon, theVehicle or source, -1.05, 0, -0.65 )
                elseif ( id == 506 ) or ( id == 451 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.57, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, -0.15, -0.57 )
                    attachElements ( neon, theVehicle or source, -0.95, -0.15, -0.57 )
                elseif ( id == 566 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.15, -0.53, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.53, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.53 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.53 )
                elseif ( id == 549 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.2, -0.47, 0, 0, 90  )
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.47 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.47 )
                elseif ( id == 576 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.47, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.05, 0.05, -0.47 )
                    attachElements ( neon, theVehicle or source, -1.05, 0.05, -0.47 )
                elseif ( id == 525 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.45, -0.39, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -1.45, -0.39, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0.05, -0.39 )
                    attachElements ( neon, theVehicle or source, -1.1, 0.05, -0.39 )
                elseif ( id == 558 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.43, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, -0.05, -0.43 )
                    attachElements ( neon, theVehicle or source, -0.95, -0.05, -0.43 )
                elseif ( id == 552 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.75, -0.3, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -0.9, -0.3, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.1, 0.45, -0.3 )
                    attachElements ( neon, theVehicle or source, -1.1, 0.45, -0.3 )
                elseif ( id == 540 ) then
                    attachElements ( neon3, theVehicle or source, 0, 1.3, -0.7, 0, 0, 90  )
                    attachElements ( neon2, theVehicle or source, 0, -1.35, -0.7, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.05, 0, -0.7 )
                    attachElements ( neon, theVehicle or source, -1.05, 0, -0.7 )
                elseif ( id == 491 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.61, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.61 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.61 )
                elseif ( id == 412 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.4, -0.64, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0, -0.64 )
                    attachElements ( neon, theVehicle or source, -0.95, 0, -0.64 )
                elseif ( id == 421 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.25, -0.66, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.95, 0.1, -0.66 )
                    attachElements ( neon, theVehicle or source, -0.95, 0.1, -0.66 )
                elseif ( id == 529 ) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.2, -0.46, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1, -0.05, -0.46 )
                    attachElements ( neon, theVehicle or source, -1, -0.05, -0.46 )
                elseif ( id == 555) then
                    destroyElement(neon3)
                    destroyElement(neon2)
                    attachElements ( neon1, theVehicle or source, 0.8, 0, -0.5 )
                    attachElements ( neon, theVehicle or source, -0.8, 0, -0.5 )
                elseif ( id == 554) then
                    destroyElement(neon3)
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.6, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.9, 0, -0.6 )
                    attachElements ( neon, theVehicle or source, -0.9, 0, -0.6 )
                elseif ( id == 477) then
                    attachElements ( neon3, theVehicle or source, 0, 1.15, -0.57, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.15, -0.57, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 0.99, 0, -0.57 )
                    attachElements ( neon, theVehicle or source, -0.99, 0, -0.57 )
                elseif ( id == 585) then
                    attachElements ( neon3, theVehicle or source, 0, 1.25, -0.42, 0, 0, 90 )
                    attachElements ( neon2, theVehicle or source, 0, -1.3, -0.42, 0, 0, 90 )
                    attachElements ( neon1, theVehicle or source, 1.05, 0, -0.42 )
                    attachElements ( neon, theVehicle or source, -1.05, 0, -0.42 )
                end
            end
end
addEventHandler( "onPlayerVehicleEnter",getRootElement(),neons )
addEvent( "attachNeon", true )
addEventHandler( "attachNeon", getRootElement(), neons )

function detachNeon( theVehicle )
    local attachedElements = getAttachedElements ( theVehicle )
    for i,v in ipairs ( attachedElements ) do
        detachElements ( v, theVehicle )
        destroyElement ( v )
    end
end
addEventHandler( "onPlayerVehicleExit", getRootElement(), detachNeon )
addEvent( "detachNeon", true )
addEventHandler( "detachNeon", getRootElement(), detachNeon )

function onPlayerQuit()
local playeraccount = getPlayerAccount ( source )
  if ( playeraccount ) and not isGuestAccount ( playeraccount ) then
     local getNeonType = getElementData(source, "neon")
     if ( getNeonType ) then
       setAccountData ( playeraccount, "neon", getNeonType)
       local theVehicle = getPedOccupiedVehicle ( source )
       if ( getNeonType ~= 0 ) and ( theVehicle ) then
          detachNeon( theVehicle )
       end
     end
  end
end
addEventHandler ( "onPlayerQuit", getRootElement ( ), onPlayerQuit )

function onPlayerLogin (_, playeraccount )
      if ( playeraccount ) then
          local getNeonTypeAccData = getAccountData ( playeraccount, "neon" )
             if ( getNeonTypeAccData ~= 0 ) then
                   setElementData(source, "neon", getNeonTypeAccData)
             end
      end
end
addEventHandler ( "onPlayerLogin", getRootElement ( ), onPlayerLogin )
