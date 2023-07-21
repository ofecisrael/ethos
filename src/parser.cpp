#include "parser.h"

namespace alfc {

Parser::Parser(State& s)
    : d_lex(),
      d_state(s),
      d_eparser(d_lex, d_state),
      d_cmdParser(d_lex, d_state, d_eparser)
{
}

void Parser::setFileInput(const std::string& filename)
{
  d_input = Input::mkFileInput(filename);
  d_lex.initialize(d_input.get(), filename);
}
  
bool Parser::parseNextCommand()
{
  return d_cmdParser.parseNextCommand();
}

}  // namespace alfc
