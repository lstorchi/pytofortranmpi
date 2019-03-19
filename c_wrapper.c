#include <string.h>
#include <stdio.h>

#ifdef USEINTELCMP

#define f_run 

#else

#define f_run __for_wrapper_MOD_run

#endif

void f_run ();

int init ()
{
  f_run();

  return 0;
}
