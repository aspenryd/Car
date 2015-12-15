{***************************************************************
 *
 * Unit Name: SendKey98.Inc
 * Purpose  : You may add or delete keys from this constant file as needed
 *            Remember to adjust the MaxKeys constant accordingly
 * Author   : Fred Schetterer
 * History  : Created on 6/26/1999
 *
 ****************************************************************}

const
   MaxKeys                              = 56;
   KeyGroupOpen                         = '{';
   KeyGroupClose                        = '}';
   ControlKey                           = '^';
   AltKey                               = '@';
   ShiftKey                             = '~';

type
   TKeyString = string[7];
   TKeyDef = record
      Key: TKeyString;
      vkCode: Byte;
   end;

type
   PKeyTranslateRec = ^PKeyTranslateRec;
   TKeyTranslateRec = record
      NonTranslatable: Char;
      Translated: Char;
      ExtendedCode: Byte;
   end;

const
   KeyDefArray                          : array[1..MaxKeys] of TKeyDef = (
      (Key: 'CTRL'; vkCode: VK_CONTROL),
      (Key: 'ALT'; vkCode: VK_MENU),
      (Key: 'MENU'; vkCode: VK_MENU),
      (Key: 'SHIFT'; vkCode: VK_SHIFT),
      (Key: 'SPACE'; vkCode: VK_SPACE),
      (Key: 'F1'; vkCode: vk_F1),
      (Key: 'F2'; vkCode: vk_F2),
      (Key: 'F3'; vkCode: vk_F3),
      (Key: 'F4'; vkCode: vk_F4),
      (Key: 'F5'; vkCode: vk_F5),
      (Key: 'F6'; vkCode: vk_F6),
      (Key: 'F7'; vkCode: vk_F7),
      (Key: 'F8'; vkCode: vk_F8),
      (Key: 'F9'; vkCode: vk_F9),
      (Key: 'F10'; vkCode: vk_F10),
      (Key: 'F11'; vkCode: vk_F11),
      (Key: 'F12'; vkCode: vk_F12),
      (Key: 'INSERT'; vkCode: vk_Insert),
      (Key: 'DELETE'; vkCode: vk_Delete),
      (Key: 'DEL'; vkCode: vk_Delete),
      (Key: 'HOME'; vkCode: vk_Home),
      (Key: 'END'; vkCode: vk_End),
      (Key: 'PGUP'; vkCode: vk_Prior),
      (Key: 'PGDN'; vkCode: vk_Next),
      (Key: 'TAB'; vkCode: vk_Tab),
      (Key: 'ENTER'; vkCode: vk_Return),
      (Key: 'BKSP'; vkCode: vk_Back),
      (Key: 'PRTSC'; vkCode: vk_SnapShot),
      (Key: 'ESCAPE'; vkCode: vk_Escape),
      (Key: 'ESC'; vkCode: vk_Escape),
      (Key: 'WIN'; vkCode: VK_LWIN),
      (Key: 'START'; vkCode: VK_RWIN),
      (Key: 'APPS'; vkCode: VK_APPS),
      (Key: 'UP'; vkCode: VK_UP),
      (Key: 'DOWN'; vkCode: VK_DOWN),
      (Key: 'LEFT'; vkCode: VK_LEFT),
      (Key: 'RIGHT'; vkCode: VK_RIGHT),
      (Key: 'DN'; vkCode: VK_DOWN),
      (Key: 'L'; vkCode: VK_LEFT),
      (Key: 'R'; vkCode: VK_RIGHT),

      (Key: 'NUM0'; vkCode: VK_NUMPAD0),
      (Key: 'NUM1'; vkCode: VK_NUMPAD1),
      (Key: 'NUM2'; vkCode: VK_NUMPAD2),
      (Key: 'NUM3'; vkCode: VK_NUMPAD3),
      (Key: 'NUM4'; vkCode: VK_NUMPAD4),
      (Key: 'NUM5'; vkCode: VK_NUMPAD5),
      (Key: 'NUM6'; vkCode: VK_NUMPAD6),
      (Key: 'NUM7'; vkCode: VK_NUMPAD7),
      (Key: 'NUM8'; vkCode: VK_NUMPAD8),
      (Key: 'NUM9'; vkCode: VK_NUMPAD9),

      (Key: 'MULTI'; vkCode: VK_MULTIPLY),
      (Key: 'ADD'; vkCode: VK_ADD),
      (Key: 'SEPARAT'; vkCode: VK_SEPARATOR),
      (Key: 'SUBTRCT'; vkCode: VK_SUBTRACT),
      (Key: 'DECIMAL'; vkCode: VK_DECIMAL),
      (Key: 'DIVIDE'; vkCode: VK_DIVIDE)
      );

const
   ICELANDIC_TranslateArray             : array[0..9] of TKeyTranslateRec = (
      (NonTranslatable: 'á'; Translated: 'a'; ExtendedCode: 222),
      (NonTranslatable: 'ó'; Translated: 'o'; ExtendedCode: 222),
      (NonTranslatable: 'í'; Translated: 'i'; ExtendedCode: 222),
      (NonTranslatable: 'Í'; Translated: 'I'; ExtendedCode: 222),
      (NonTranslatable: 'ý'; Translated: 'y'; ExtendedCode: 222),
      (NonTranslatable: 'Ý'; Translated: 'Y'; ExtendedCode: 222),
      (NonTranslatable: 'ú'; Translated: 'u'; ExtendedCode: 222),
      (NonTranslatable: 'Ú'; Translated: 'U'; ExtendedCode: 222),
      (NonTranslatable: 'Á'; Translated: 'A'; ExtendedCode: 222),
      (NonTranslatable: 'Ó'; Translated: 'O'; ExtendedCode: 222)
      );


