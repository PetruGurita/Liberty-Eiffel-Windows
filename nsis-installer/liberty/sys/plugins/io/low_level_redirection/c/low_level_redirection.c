/*
-- ------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2005: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
-- documentation files (the "Software"), to deal in the Software without restriction, including without
-- limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
-- the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
-- conditions:
--
-- The above copyright notice and this permission notice shall be included in all copies or substantial
-- portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
-- LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
-- EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
-- AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
-- OR OTHER DEALINGS IN THE SOFTWARE.
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------
*/
#if defined __USE_POSIX || defined __unix__ || defined _POSIX_C_SOURCE
int open_descriptor_for_read(char *filename) {
  int result;

  do
    result = open (filename, O_RDONLY);
  while (result == -1L && errno == EINTR);
  return result;
}

int open_descriptor_for_create(char *filename) {
  int result;

  do
    result = open (filename, O_WRONLY|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
  while (result == -1L && errno == EINTR);
  return result;
}

int open_descriptor_for_append(char *filename) {
  int result;

  do
    result = open (filename, O_WRONLY|O_APPEND|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
  while (result == -1L && errno == EINTR);
  return result;
}

int open_descriptor_succeeded(int descriptor) {
  return descriptor >= 0;
}

void close_descriptor(int descriptor) {
  int result;

  do
    result = close (descriptor);
  while (result == -1L && errno == EINTR);
}
#else
int open_descriptor_for_read(char *filename) {
  return _open (filename, _O_RDONLY);
}

int open_descriptor_for_create(char *filename) {
#ifdef __BORLANDC__
  return open (filename, _O_WRONLY|_O_TRUNC|_O_CREAT, _S_IREAD | _S_IWRITE);
#else
  return _open (filename, _O_WRONLY|_O_TRUNC|_O_CREAT, _S_IREAD | _S_IWRITE);
#endif
}

int open_descriptor_for_append(char *filename) {
#ifdef __BORLANDC__
  return open (filename, _O_WRONLY|_O_APPEND|_O_CREAT, _S_IREAD | _S_IWRITE);
#else
  return _open (filename, _O_WRONLY|_O_APPEND|_O_CREAT, _S_IREAD | _S_IWRITE);
#endif
}

int open_descriptor_succeeded(int descriptor) {
  return descriptor >= 0;
}

void close_descriptor(int descriptor) {
  _close (descriptor);
}
#endif
