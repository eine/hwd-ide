#include <stdio.h>
#include <vpi_user.h>

void
vpi_proc (void)
{
  vpiHandle top_iter;
  vpiHandle module_h;
  vpiHandle net_iter;
  vpiHandle h;

  /* get TOP Module handle */
  top_iter = vpi_iterate (vpiModule, NULL);
  module_h = vpi_scan (top_iter);
  if (module_h == NULL)
    {
      printf("vpiModule no more nets\n");
    }
  else
    {
      const char *mod_name;
      vpiHandle scope_h;

      mod_name = vpi_get_str (vpiFullName, module_h);
      printf ("TOP Module Name = %s\n", mod_name);
      scope_h = vpi_handle (vpiScope, module_h);
      if (scope_h != NULL)
	{
	  vpiHandle sig_iter;

	  sig_iter = vpi_iterate (vpiNet, scope_h);
	  if (sig_iter != NULL)
	    {
	      vpiHandle signal_h;

	      while ((signal_h = vpi_scan (sig_iter)) != NULL)
		{
		  int signal_type;
		  const char *mod_name;

		  signal_type = vpi_get (vpiType, signal_h);
		  mod_name = vpi_get_str (vpiName, signal_h);
		  printf ("NET Name = %s\n", mod_name);
		}
	    }
	  else
	    {
	      printf ("net sig_iter NULL\n");
	    }
	  sig_iter = vpi_iterate (vpiReg, scope_h);
	  if (sig_iter != NULL)
	    {
	      vpiHandle signal_h;

	      while ((signal_h = vpi_scan (sig_iter)) != NULL)
		{
		  int signal_type;
		  const char *mod_name;

		  signal_type = vpi_get (vpiType, signal_h);
		  mod_name = vpi_get_str (vpiName, signal_h);
		  printf ("REG Name = %s\n", mod_name);
		}
	    }
	  else
	    {
	      printf ("reg sig_iter NULL\n");
	    }
	}
      else
	{
	  printf ("No Signals\n");
	}
    }
  
  /* get TOP Module Nets */
  net_iter = vpi_iterate (vpiNet, module_h);
  if (net_iter != NULL)
    {
      vpiHandle net_h;

      while ((net_h = vpi_scan (net_iter)) != NULL)
	{
	  const char *mod_name;
	  mod_name = vpi_get_str (vpiFullName, net_h);
	  printf ("Net Name = %s\n", mod_name);
	}
    }
  else
    {
      printf("No Nets\n");
    }
  
  /* get TOP Module Regs */
  net_iter = vpi_iterate (vpiReg, module_h);
  if (net_iter != NULL)
    {
      vpiHandle net_h;

      while ((net_h = vpi_scan (net_iter)) != NULL)
	{
	  const char *mod_name;

	  mod_name = vpi_get_str (vpiFullName, net_h);
	  printf ("Reg Name = %s\n", mod_name);
	}
    }
  else 
    {
      printf ("No Regs\n");
    }
  
  /* get TOP Module one to one Nets */
  h = vpi_handle (vpiNet, module_h);
  if (h != NULL)
    {
      const char *mod_name;
      mod_name = vpi_get_str (vpiFullName, h);
      printf ("Reg Name = %s\n", mod_name);
    }
  else
    {
      printf ("No Top Level Nets\n");
    }
  
  /* get TOP Module one to one Nets */
  h = vpi_handle (vpiReg, module_h);
  if (h != NULL)
    {
      const char *mod_name;
      mod_name = vpi_get_str (vpiFullName, h);
      printf ("Reg Name = %s\n",mod_name);
    }
  else
    {
      printf ("No Top Level Regs\n");
    }
}

void my_handle_register()
{
  s_cb_data cb;

  cb.reason = cbEndOfCompile;
  cb.cb_rtn = &vpi_proc;
  cb.user_data = NULL;
  if (vpi_register_cb (&cb) == NULL)
    vpi_printf ("cannot register EndOfCompile call back\n");
}

void (*vlog_startup_routines[]) () =
{
  my_handle_register,
  0
};
