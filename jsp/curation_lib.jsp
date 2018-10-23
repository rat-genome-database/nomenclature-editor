<%! 
    public boolean requestContains (HttpServletRequest request, String param, String testValue) {

      String rp[] = request.getParameterValues(param);
      if (rp == null) 
        return false;
      for (int i=0; i < rp.length; i++) 
        if (rp[i].equals(testValue))
          return true;
      return false;
    }
    //************************
    public String isChecked (HttpServletRequest request, String param, String testValue) {
      return (requestContains(request, param, testValue)) ? "checked" : "";
    }

    //************************
    public String isChecked (String param, String testValue) {
      return ((param.equals(testValue))||(testValue == null)) ? "checked" : "";
    }
    
    //************************
    public String isSelected (HttpServletRequest request, String param, String testValue) {
      return (requestContains(request, param, testValue)) ? "selected" : "";
    }

    //************************
    public String itemSelected (String param, String testValue)  {
      return ((param.equals(testValue))||(testValue == null)) ? "selected" : "";
    }

    //************************
    public String formatTicks(String string) {
      if ((string == null)||(string.equals(""))) {
          return "";
      }
      else {
          char[] in  = string.toCharArray();
          StringBuffer out = new StringBuffer((int)(in.length * 1.1));

          for (int i=0; i < in.length; i++) {
            out.append(in[i]);
            if (in[i] == '\'')
            out.append(in[i]);
          }
          return out.toString();
      }
    } 
%>
