//+------------------------------------------------------------------+
//|                                                      Program.mqh |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                              http://www.mql5.com |
//+------------------------------------------------------------------+
#include <EasyAndFastGUI\Controls\WndEvents.mqh>
//+------------------------------------------------------------------+
//| Class for creating an application                                |
//+------------------------------------------------------------------+
class CProgram : public CWndEvents
  {
private:
   //--- Form 1
   CWindow           m_window1;
   //--- Main menu and its context menus
   CMenuBar          m_menubar;
   CContextMenu      m_mb_contextmenu1;
   CContextMenu      m_mb_contextmenu2;
   CContextMenu      m_mb_contextmenu3;
   CContextMenu      m_mb_contextmenu4;
   //--- Checkboxes
   CCheckBox         m_checkbox1;
   CCheckBox         m_checkbox2;
   CCheckBox         m_checkbox3;
   CCheckBox         m_checkbox4;
   CCheckBox         m_checkbox5;
   //--- Edits
   CSpinEdit         m_spin_edit1;
   //--- Check boxes with edits
   CCheckBoxEdit     m_checkboxedit1;
   //--- Comboboxes with checkboxes
   CCheckComboBox    m_checkcombobox1;
   //--- Sliders
   CSlider           m_slider1;
   CDualSlider       m_dual_slider1;
   //--- Status Bar
   CStatusBar        m_status_bar;
   //---
public:
                     CProgram(void);
                    ~CProgram(void);
   //--- Initialization/deinitialization
   void              OnInitEvent(void);
   void              OnDeinitEvent(const int reason);
   //--- Timer
   void              OnTimerEvent(void);
   //---
protected:
   //--- Chart event handler
   virtual void      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);
   //---
public:
   //--- Create the indicator panel
   bool              CreateIndicatorPanel(void);
   //---
private:
   //--- Form 1
   bool              CreateWindow1(const string text);

   //--- Main menu and its context menus
#define MENUBAR_GAP_X         (1)
#define MENUBAR_GAP_Y         (20)
   bool              CreateMenuBar(void);
   bool              CreateMBContextMenu1(void);
   bool              CreateMBContextMenu2(void);
   bool              CreateMBContextMenu3(void);
   bool              CreateMBContextMenu4(void);
   //--- Status Bar
#define STATUSBAR1_GAP_X      (1)
#define STATUSBAR1_GAP_Y      (335)
   bool              CreateStatusBar(void);
   //--- Checkboxes
#define CHECKBOX1_GAP_X       (7)
#define CHECKBOX1_GAP_Y       (50)
   bool              CreateCheckBox1(const string text);
#define CHECKBOX2_GAP_X       (30)
#define CHECKBOX2_GAP_Y       (75)
   bool              CreateCheckBox2(const string text);
#define CHECKBOX3_GAP_X       (7)
#define CHECKBOX3_GAP_Y       (100)
   bool              CreateCheckBox3(const string text);
#define CHECKBOX4_GAP_X       (7)
#define CHECKBOX4_GAP_Y       (150)
   bool              CreateCheckBox4(const string text);
#define CHECKBOX5_GAP_X       (7)
#define CHECKBOX5_GAP_Y       (200)
   bool              CreateCheckBox5(const string text);
   //--- Edits
#define SPINEDIT1_GAP_X       (150)
#define SPINEDIT1_GAP_Y       (75)
   bool              CreateSpinEdit1(const string text);
   //--- Check boxes with edits
#define CHECKBOXEDIT1_GAP_X   (30)
#define CHECKBOXEDIT1_GAP_Y   (125)
   bool              CreateCheckBoxEdit1(const string text);
   //--- Comboboxes with checkboxes
#define CHECKCOMBOBOX1_GAP_X  (30)
#define CHECKCOMBOBOX1_GAP_Y  (175)
   bool              CreateCheckComboBox1(const string text);
   //--- Sliders
#define SLIDER1_GAP_X         (32)
#define SLIDER1_GAP_Y         (225)
   bool              CreateSlider1(const string text);
#define DUALSLIDER1_GAP_X     (32)
#define DUALSLIDER1_GAP_Y     (275)
   bool              CreateDualSlider1(const string text);
  };
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CProgram::CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CProgram::~CProgram(void)
  {
  }
//+------------------------------------------------------------------+
//| Initialization                                                   |
//+------------------------------------------------------------------+
void CProgram::OnInitEvent(void)
  {
  }
//+------------------------------------------------------------------+
//| Uninitialization                                                 |
//+------------------------------------------------------------------+
void CProgram::OnDeinitEvent(const int reason)
  {
//--- Removing the interface
   CWndEvents::Destroy();
  }
//+------------------------------------------------------------------+
//| Timer                                                            |
//+------------------------------------------------------------------+
void CProgram::OnTimerEvent(void)
  {
   CWndEvents::OnTimerEvent();
//--- Updating the second item of the status bar every 500 milliseconds
   static int count=0;
   if(count<500)
     {
      count+=TIMER_STEP_MSC;
      return;
     }
//--- Zero the counter
   count=0;
//--- Change the value in the second item of the status bar
   m_status_bar.ValueToItem(1,TimeToString(TimeLocal(),TIME_DATE|TIME_SECONDS));
//--- Redraw the chart
   m_chart.Redraw();
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CProgram::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
//--- Clicking on the menu item event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_CONTEXTMENU_ITEM)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- The text label press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_LABEL)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
      //--- If the press was on the first checkbox
      if(lparam==m_checkbox1.Id())
        {
         //--- Set the state for the second checkbox and the first edit
         m_checkbox2.CheckBoxState(m_checkbox1.CheckButtonState());
         m_spin_edit1.SpinEditState(m_checkbox1.CheckButtonState());
        }
      //--- If the press was on the third checkbox
      if(lparam==m_checkbox3.Id())
        {
         //--- Set the state for the first edit with a checkbox
         m_checkboxedit1.CheckBoxEditState(m_checkbox3.CheckButtonState());
        }
      //--- If the press was on the fourth checkbox
      if(lparam==m_checkbox4.Id())
        {
         //--- Set the state for the first combobox with a checkbox
         m_checkcombobox1.CheckComboBoxState(m_checkbox4.CheckButtonState());
        }
      //--- If the fifth checkbox was clicked on
      if(lparam==m_checkbox5.Id())
        {
         //--- Set state for sliders
         m_slider1.SliderState(m_checkbox5.CheckButtonState());
         m_dual_slider1.SliderState(m_checkbox5.CheckButtonState());
        }
     }
//--- The end of value entry in edit event
   if(id==CHARTEVENT_CUSTOM+ON_END_EDIT)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Switching buttons of the edit press event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_INC || id==CHARTEVENT_CUSTOM+ON_CLICK_DEC)
     {
      ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
//--- Selection of item in combobox event
   if(id==CHARTEVENT_CUSTOM+ON_CLICK_COMBOBOX_ITEM)
     {
      if(sparam==m_checkcombobox1.LabelText())
         ::Print(__FUNCTION__," > id: ",id,"; lparam: ",lparam,"; dparam: ",dparam,"; sparam: ",sparam);
     }
  }
//+------------------------------------------------------------------+
//| Create indicator panel                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateIndicatorPanel(void)
  {
//--- Creating form 1 for controls
   if(!CreateWindow1("INDICATOR PANEL"))
      return(false);
//--- Creating controls:
//    Main menu
   if(!CreateMenuBar())
      return(false);
//--- Context menus
   if(!CreateMBContextMenu1())
      return(false);
   if(!CreateMBContextMenu2())
      return(false);
   if(!CreateMBContextMenu3())
      return(false);
   if(!CreateMBContextMenu4())
      return(false);
//--- Creating the status bar
   if(!CreateStatusBar())
      return(false);
//--- Checkboxes
   if(!CreateCheckBox1("Checkbox 1"))
      return(false);
   if(!CreateCheckBox2("Checkbox 2"))
      return(false);
   if(!CreateCheckBox3("Checkbox 3"))
      return(false);
   if(!CreateCheckBox4("Checkbox 4"))
      return(false);
   if(!CreateCheckBox5("Checkbox 5"))
      return(false);
//--- Edits
   if(!CreateSpinEdit1("Spin Edit 1:"))
      return(false);
//--- Check boxes with edits
   if(!CreateCheckBoxEdit1("Checkbox Edit 1:"))
      return(false);
//--- Comboboxes with checkboxes
   if(!CreateCheckComboBox1("CheckCombobox 1:"))
      return(false);
//--- Sliders
   if(!CreateSlider1("Slider 1:"))
      return(false);
   if(!CreateDualSlider1("Dual Slider 1:"))
      return(false);
//--- Redrawing the chart
   m_chart.Redraw();
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates form 1 for controls                                      |
//+------------------------------------------------------------------+
bool CProgram::CreateWindow1(const string caption_text)
  {
//--- Add the window pointer to the window array
   CWndContainer::AddWindow(m_window1);
//--- Coordinates
   int x=(m_window1.X()>0) ? m_window1.X() : 1;
   int y=(m_window1.Y()>0) ? m_window1.Y() : 20;
//--- Properties
   m_window1.XSize(306);
   m_window1.YSize(360);
   m_window1.Movable(true);
   m_window1.UseRollButton();
//--- Creating the form
   if(!m_window1.CreateWindow(m_chart_id,m_subwin,caption_text,x,y))
      return(false);
//---
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the main menu                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateMenuBar(void)
  {
//--- Three items in the main menu
#define MENUBAR_TOTAL 3
//--- Store the window pointer
   m_menubar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+MENUBAR_GAP_X;
   int y=m_window1.Y()+MENUBAR_GAP_Y;
//--- Arrays with unique properties of each item
   int    width[MENUBAR_TOTAL] ={50,55,53};
   string text[MENUBAR_TOTAL]  ={"File","View","Help"};
//--- Set properties before creation
   m_menubar.AutoXResizeMode(true);
   m_menubar.AutoXResizeRightOffset(1);
//--- Add items to the main menu
   for(int i=0; i<MENUBAR_TOTAL; i++)
      m_menubar.AddItem(width[i],text[i]);
//--- Create control
   if(!m_menubar.CreateMenuBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_menubar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\script_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\safe_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\pie_chart_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\calculator_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice.bmp"
#resource "\\Images\\EasyAndFastGUI\\Icons\\bmp16\\invoice_gray.bmp"
#resource "\\Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
//---
bool CProgram::CreateMBContextMenu1(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS1 3
//--- Store the window pointer
   m_mb_contextmenu1.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu1.PrevNodePointer(m_menubar.ItemPointerByIndex(0));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(0,m_mb_contextmenu1);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS1]=
     {
      "ContextMenu 1 Item 1",
      "ContextMenu 1 Item 2",
      "ContextMenu 1 Item 3..."
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp"
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS1]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_SIMPLE
     };
//--- Set properties before creation
   m_mb_contextmenu1.FixSide(FIX_BOTTOM);
   m_mb_contextmenu1.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS1; i++)
      m_mb_contextmenu1.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu1.AddSeparateLine(1);
//--- Deactivate the second item
   m_mb_contextmenu1.ItemPointerByIndex(1).ItemState(false);
//--- Create a context menu
   if(!m_mb_contextmenu1.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu2(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS2 3
//--- Store the window pointer
   m_mb_contextmenu2.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu2.PrevNodePointer(m_menubar.ItemPointerByIndex(1));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(1,m_mb_contextmenu2);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS2]=
     {
      "ContextMenu 2 Item 1",
      "ContextMenu 2 Item 2",
      "ContextMenu 2 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS2]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS2]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu2.FixSide(FIX_BOTTOM);
   m_mb_contextmenu2.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS2; i++)
      m_mb_contextmenu2.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu2.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu2.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
#resource "\\Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp"
//---
bool CProgram::CreateMBContextMenu3(void)
  {
//--- Five items in the context menu
#define CONTEXTMENU_ITEMS3 5
//--- Store the window pointer
   m_mb_contextmenu3.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu3.PrevNodePointer(m_menubar.ItemPointerByIndex(2));
//--- Attach the context menu to the specified menu item
   m_menubar.AddContextMenuPointer(2,m_mb_contextmenu3);
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS3]=
     {
      "ContextMenu 3 Item 1",
      "ContextMenu 3 Item 2",
      "ContextMenu 3 Item 3...",
      "ContextMenu 3 Item 4",
      "ContextMenu 3 Item 5"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart.bmp",
      "",""
     };
//--- Array of icon for the blocked mode 
   string items_bmp_off[CONTEXTMENU_ITEMS3]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\bar_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS3]=
     {
      MI_SIMPLE,
      MI_HAS_CONTEXT_MENU,
      MI_SIMPLE,
      MI_CHECKBOX,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu3.FixSide(FIX_BOTTOM);
   m_mb_contextmenu3.XSize(160);
   m_mb_contextmenu3.RightArrowFileOff("Images\\EasyAndFastGUI\\Controls\\RArrow_black.bmp");
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS3; i++)
      m_mb_contextmenu3.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the third item
   m_mb_contextmenu3.AddSeparateLine(2);
//--- Create a context menu
   if(!m_mb_contextmenu3.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates a context menu                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateMBContextMenu4(void)
  {
//--- Six items in a context menu
#define CONTEXTMENU_ITEMS4 3
//--- Store the window pointer
   m_mb_contextmenu4.WindowPointer(m_window1);
//--- Store the pointer to the previous node
   m_mb_contextmenu4.PrevNodePointer(m_mb_contextmenu3.ItemPointerByIndex(1));
//--- Array of the menu item names
   string items_text[CONTEXTMENU_ITEMS4]=
     {
      "ContextMenu 4 Item 1",
      "ContextMenu 4 Item 2",
      "ContextMenu 4 Item 3"
     };
//--- Array of icons for the available mode
   string items_bmp_on[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart.bmp",
      ""
     };
//--- Array of icon for the blocked mode
   string items_bmp_off[CONTEXTMENU_ITEMS4]=
     {
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\coins_gray.bmp",
      "Images\\EasyAndFastGUI\\Icons\\bmp16\\line_chart_gray.bmp",
      "Images\\EasyAndFastGUI\\Controls\\CheckBoxOn_min_black.bmp"
     };
//--- Array of item types
   ENUM_TYPE_MENU_ITEM items_type[CONTEXTMENU_ITEMS4]=
     {
      MI_SIMPLE,
      MI_SIMPLE,
      MI_CHECKBOX
     };
//--- Set properties before creation
   m_mb_contextmenu4.XSize(160);
//--- Add items to the context menu
   for(int i=0; i<CONTEXTMENU_ITEMS4; i++)
      m_mb_contextmenu4.AddItem(items_text[i],items_bmp_on[i],items_bmp_off[i],items_type[i]);
//--- Separation line after the second item
   m_mb_contextmenu4.AddSeparateLine(1);
//--- Create a context menu
   if(!m_mb_contextmenu4.CreateContextMenu(m_chart_id,m_subwin))
      return(false);
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_mb_contextmenu4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates the status bar                                           |
//+------------------------------------------------------------------+
bool CProgram::CreateStatusBar(void)
  {
#define STATUS_LABELS_TOTAL 2
//--- Store the window pointer
   m_status_bar.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+STATUSBAR1_GAP_X;
   int y=m_window1.Y()+STATUSBAR1_GAP_Y;
//--- Width
   int width[]={0,110};
//--- Set properties before creation
   m_status_bar.YSize(24);
   m_status_bar.AutoXResizeMode(true);
   m_status_bar.AutoXResizeRightOffset(1);
//--- Specify the number of parts and set their properties
   for(int i=0; i<STATUS_LABELS_TOTAL; i++)
      m_status_bar.AddItem(width[i]);
//--- Create control
   if(!m_status_bar.CreateStatusBar(m_chart_id,m_subwin,x,y))
      return(false);
//--- Set text in the first item of the status bar
   m_status_bar.ValueToItem(0,"For Help, press F1");
//--- Add the element pointer to the base
   CWndContainer::AddToElementsArray(0,m_status_bar);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox1(string text)
  {
//--- Store the window pointer
   m_checkbox1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX1_GAP_X;
   int y=m_window1.Y()+CHECKBOX1_GAP_Y;
//--- Set properties before creation
   m_checkbox1.XSize(90);
   m_checkbox1.YSize(18);
//--- Create control
   if(!m_checkbox1.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 2                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox2(string text)
  {
//--- Store the window pointer
   m_checkbox2.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX2_GAP_X;
   int y=m_window1.Y()+CHECKBOX2_GAP_Y;
//--- Set properties before creation
   m_checkbox2.XSize(90);
   m_checkbox2.YSize(18);
//--- Create control
   if(!m_checkbox2.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the first checkbox
   m_checkbox2.CheckBoxState(m_checkbox1.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox2);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 3                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox3(string text)
  {
//--- Store the window pointer
   m_checkbox3.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX3_GAP_X;
   int y=m_window1.Y()+CHECKBOX3_GAP_Y;
//--- Set properties before creation
   m_checkbox3.XSize(90);
   m_checkbox3.YSize(18);
//--- Create control
   if(!m_checkbox3.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox3);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 4                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox4(string text)
  {
//--- Store the window pointer
   m_checkbox4.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX4_GAP_X;
   int y=m_window1.Y()+CHECKBOX4_GAP_Y;
//--- Set properties before creation
   m_checkbox4.XSize(90);
   m_checkbox4.YSize(18);
//--- Create control
   if(!m_checkbox4.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox4);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 5                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBox5(string text)
  {
//--- Store the window pointer
   m_checkbox5.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOX5_GAP_X;
   int y=m_window1.Y()+CHECKBOX5_GAP_Y;
//--- Set properties before creation
   m_checkbox5.XSize(90);
   m_checkbox5.YSize(18);
//--- Create control
   if(!m_checkbox5.CreateCheckBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkbox5);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates edit 1                                                   |
//+------------------------------------------------------------------+
bool CProgram::CreateSpinEdit1(string text)
  {
//--- Store the window pointer
   m_spin_edit1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SPINEDIT1_GAP_X;
   int y=m_window1.Y()+SPINEDIT1_GAP_Y;
//--- Value
   double v=(m_spin_edit1.GetValue()==WRONG_VALUE) ? 4 : m_spin_edit1.GetValue();
//--- Set properties before creation
   m_spin_edit1.XSize(150);
   m_spin_edit1.YSize(18);
   m_spin_edit1.EditXSize(76);
   m_spin_edit1.MaxValue(1000);
   m_spin_edit1.MinValue(-1000);
   m_spin_edit1.StepValue(1);
   m_spin_edit1.SetDigits(0);
   m_spin_edit1.SetValue(v);
   m_spin_edit1.ResetMode(true);
//--- Create control
   if(!m_spin_edit1.CreateSpinEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the first checkbox
   m_spin_edit1.SpinEditState(m_checkbox1.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_spin_edit1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates checkbox 1                                               |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckBoxEdit1(string text)
  {
//--- Store the window pointer
   m_checkboxedit1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKBOXEDIT1_GAP_X;
   int y=m_window1.Y()+CHECKBOXEDIT1_GAP_Y;
//--- Value
   double v=(m_checkboxedit1.GetValue()<0) ? ::rand()%1000 : m_checkboxedit1.GetValue();
//--- Set properties before creation
   m_checkboxedit1.XSize(270);
   m_checkboxedit1.YSize(18);
   m_checkboxedit1.EditXSize(75);
   m_checkboxedit1.MaxValue(1000);
   m_checkboxedit1.MinValue(1);
   m_checkboxedit1.StepValue(1);
   m_checkboxedit1.SetDigits(0);
   m_checkboxedit1.SetValue(v);
//--- Create control
   if(!m_checkboxedit1.CreateCheckBoxEdit(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the third checkbox
   m_checkboxedit1.CheckBoxEditState(m_checkbox3.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkboxedit1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates check-combo box 1                                        |
//+------------------------------------------------------------------+
bool CProgram::CreateCheckComboBox1(const string text)
  {
//--- Store the window pointer
   m_checkcombobox1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+CHECKCOMBOBOX1_GAP_X;
   int y=m_window1.Y()+CHECKCOMBOBOX1_GAP_Y;
//--- List view contents
   string m_tf[21]=
     {
      "item 1","item 2","item 3","item 4","item 5","item 6","item 7","item 8","item 9","item 10",
      "item 11","item 12","item 13","item 14","item 15","item 16","item 17","item 18","item 19","item 20","item 21"
     };
//--- Set properties before creation
   m_checkcombobox1.XSize(266);
   m_checkcombobox1.YSize(18);
   m_checkcombobox1.ButtonXSize(87);
   m_checkcombobox1.ItemsTotal(21);
   m_checkcombobox1.VisibleItemsTotal(5);
//--- List properties
   CListView *lv=m_checkcombobox1.GetListViewPointer();
   lv.LightsHover(true);
   lv.SelectedItemByIndex(lv.SelectedItemIndex()==WRONG_VALUE ? 4 : lv.SelectedItemIndex());
//--- Save the values to the list
   for(int i=0; i<21; i++)
      m_checkcombobox1.ValueToList(i,m_tf[i]);
//--- Create control
   if(!m_checkcombobox1.CreateCheckComboBox(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- The availability will depend on the current state of the fourth checkbox
   m_checkcombobox1.CheckComboBoxState(m_checkbox4.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_checkcombobox1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates slider 1                                                 |
//+------------------------------------------------------------------+
bool CProgram::CreateSlider1(const string text)
  {
//--- Store the window pointer
   m_slider1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+SLIDER1_GAP_X;
   int y=m_window1.Y()+SLIDER1_GAP_Y;
//--- Value
   double v=(m_slider1.GetValue()==WRONG_VALUE) ? 0.84615385 : m_slider1.GetValue();
//--- Set properties before creation
   m_slider1.XSize(264);
   m_slider1.YSize(40);
   m_slider1.EditXSize(87);
   m_slider1.MaxValue(1);
   m_slider1.StepValue(0.00000001);
   m_slider1.MinValue(-1);
   m_slider1.SetDigits(8);
   m_slider1.SetValue(v);
//--- Create control
   if(!m_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Availability will depend on the current state of the fifth checkbox
   m_slider1.SliderState(m_checkbox5.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
//| Creates dual slider 1                                            |
//+------------------------------------------------------------------+
bool CProgram::CreateDualSlider1(const string text)
  {
//--- Store the window pointer
   m_dual_slider1.WindowPointer(m_window1);
//--- Coordinates
   int x=m_window1.X()+DUALSLIDER1_GAP_X;
   int y=m_window1.Y()+DUALSLIDER1_GAP_Y;
//--- Values
   double v1=(m_dual_slider1.GetLeftValue()==WRONG_VALUE) ? 0 : m_dual_slider1.GetLeftValue();
   double v2=(m_dual_slider1.GetRightValue()==WRONG_VALUE) ? 500 : m_dual_slider1.GetRightValue();
//--- Set properties before creation
   m_dual_slider1.XSize(264);
   m_dual_slider1.YSize(40);
   m_dual_slider1.EditXSize(87);
   m_dual_slider1.MaxValue(1000);
   m_dual_slider1.StepValue(10);
   m_dual_slider1.MinValue(-2000);
   m_dual_slider1.SetDigits(0);
   m_dual_slider1.SetLeftValue(v1);
   m_dual_slider1.SetRightValue(v2);
//--- Create control
   if(!m_dual_slider1.CreateSlider(m_chart_id,m_subwin,text,x,y))
      return(false);
//--- Availability will depend on the current state of the fifth checkbox
   m_dual_slider1.SliderState(m_checkbox5.CheckButtonState());
//--- Add the object to the common array of object groups
   CWndContainer::AddToElementsArray(0,m_dual_slider1);
   return(true);
  }
//+------------------------------------------------------------------+
