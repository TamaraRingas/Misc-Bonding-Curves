// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/* ____ ____  ____   ___  ____  ____  
 | ____|  _ \|  _ \ / _ \|  _ \/ ___| 
 |  _| | |_) | |_) | | | | |_) \___ \ 
 | |___|  _ <|  _ <| |_| |  _ < ___) |
 |_____|_| \_\_| \_\\___/|_| \_\____/
***********************************/

library LibErrors {

  error CurveInitialized();
  
  error CurvePaused();

  error IncorrectInput();

  error InsufficientFunds();

  error CannotBuyZero();

  error CannotSellZero();

  error TokensNotAvailable();

  error NoMISC();

  error Max500KTokensPerTransaction();

}