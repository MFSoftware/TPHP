{$DEFINE PHP5}

{$DEFINE PHP504}
{$DEFINE PHP510}
{$DEFINE PHP511}
{$DEFINE PHP512}
{$DEFINE PHP520}
{$DEFINE PHP530}
{$DEFINE PHP540}

{$IFDEF PHP530}
  {$DEFINE ZEND_WIN32}
  {$DEFINE PHP_COMPILER_ID}
{$ENDIF}

{$IFDEF PHP_COMPILER_ID}
 {$DEFINE COMPILER_VC9}
{$ENDIF}

{$IFDEF PHP5}
  {$UNDEF PHP4}
  {$UNDEF PHP430}
  {$UNDEF PHP433}
  {$UNDEF PHP435}
  {$UNDEF PHP446}
{$ENDIF}

{$DEFINE REGISTER_COLORS}

{$IFNDEF LINUX}
 {$DEFINE ZTS}                                              
{$ENDIF}

{$IFNDEF VER80}                                             {Delphi 1.0}
  {$DEFINE VERSION2}                                        {Delphi 2.0 and BCB 1 or higher}
{$ENDIF}

{$IFDEF VERSION2}
  {$IFNDEF VER90}                                           {Delphi 2.0}
    {$IFNDEF VER93}                                         {BCB 1.0}
      {$DEFINE VERSION3}                                    {Delphi 3.0 or BCB 3.0}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION3}
  {$IFNDEF VER100}                                          {Delphi 3}
    {$IFNDEF VER110}                                        {BCB 3}
      {$DEFINE VERSION4}                                    {Delphi 4.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION4}
  {$IFNDEF VER120}                                          {Delphi 4}
    {$IFNDEF VER125}                                        {BCB 4}
      {$DEFINE VERSION5}                                    {Delphi 5.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VER130}                                          {Delphi 5}
    {$IFNDEF VER135}                                        {BCB 5}
      {$DEFINE VERSION6}                                    {Delphi 6.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
  {$IFNDEF VER140}                                          {Delphi 6}
    {$IFNDEF VER145}                                        {BCB 6}
      {$DEFINE VERSION7}                                    {Delphi 7.0 or higher}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION7}
 {$IFNDEF VER150}                                           {Delphi 7}
     {$DEFINE VERSION9}                                     {Delphi 2005}
 {$ENDIF}
{$ENDIF}

{$IFDEF VERSION9}
  {$IFNDEF VER170}                                          {Delphi 2005}
    {$DEFINE VERSION10}                                     {Delphi 2006}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION10}
  {$IFNDEF VER180}                                          {Delphi 2006}
    {$DEFINE VERSION11}                                     {Delphi 2007}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION11}
  {$IFNDEF VER185}                                          {Delphi 2007}
    {$DEFINE VERSION12}                                     {Delphi 2009}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION12}
  {$IFNDEF VERSION20}
    {$DEFINE VERSION13}                                     {Delphi 2010}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
  {$WARN SYMBOL_PLATFORM OFF}
  {$IFDEF VERSION7}
    {$WARN UNIT_PLATFORM OFF}
    {$WARN UNSAFE_CODE OFF}
    {$WARN UNSAFE_TYPE OFF}
    {$WARN UNSAFE_CAST OFF}
    {$WARN UNIT_DEPRECATED OFF}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION5}
  {$IFNDEF VERSION6}
    {$DEFINE VERSION5ONLY}
  {$ENDIF}
{$ENDIF}

{$IFDEF VERSION6}
{$A8}
{$ELSE}
{$A+}
{$ENDIF}


{$IFDEF VERSION7}
{$J+}
{$WARNINGS OFF}
{$ENDIF}
