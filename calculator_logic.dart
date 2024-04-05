class CalculatorLogic {
  double _buffer = 0.0;
  String _currentOperator = '';
  double _result = 0.0;

  String processInput(String input) {
    if (input == 'C') {
      _clear();
    } else if (input == '=') {
      _calculate();
    } else if (_isOperator(input)) {
      _handleOperator(input);
    } else {
      _appendToBuffer(input);
    }

    return _formatOutput(_buffer);
  }

  bool _isOperator(String value) {
    return ['+', '-', '*', '/'].contains(value);
  }

  void _appendToBuffer(String value) {
    if (_buffer == 0.0 || _buffer == null) {
      _buffer = double.parse(value);
    } else {
      _buffer = double.parse('$_buffer$value');
    }
  }

  void _handleOperator(String operator) {
    if (_currentOperator != '') {
      _calculate();
    }

    _currentOperator = operator;
    _result = _buffer;
    _buffer = 0.0;
  }

  void _calculate() {
    if (_currentOperator != '') {
      switch (_currentOperator) {
        case '+':
          _result += _buffer;
          break;
        case '-':
          _result -= _buffer;
          break;
        case '*':
          _result *= _buffer;
          break;
        case '/':
          if (_buffer != 0) {
            _result /= _buffer;
          } else {
            _buffer = double.nan;
            return;
          }
          break;
      }

      _buffer = _result;
      _currentOperator = '';
    }
  }

  void _clear() {
    _buffer = 0.0;
    _currentOperator = '';
    _result = 0.0;
  }

  String _formatOutput(double value) {
    String formattedOutput = value.toStringAsFixed(2);
    if (formattedOutput.endsWith('.00')) {
      return value.toInt().toString();
    }
    return formattedOutput;
  }

  void clear() {}
}