import React from 'react';
import { HeaderFour, HelpCircle } from 'components/base';
import { styled } from 'components/theme';
import Tip from './Tip';

const Styled = {
  Wrapper: styled.div``,
  Info: styled.div<{ error?: boolean }>`
    width: 100%;
    margin: 0 0 30px;
    padding: 5px 0;
    font-size: ${props => props.theme.sizes.s};
    background-color: ${props => (props.error ? props.theme.colors.pink : 'transparent')};
    color: ${props =>
      props.error ? props.theme.colors.offWhite : props.theme.colors.gray};
    text-align: ${props => (props.error ? 'center' : 'right')};
  `,
};

interface Props {
  label: string;
  info?: string;
  error?: string;
  tip?: string;
}

const FormField: React.FC<Props> = ({ label, info, error, tip, children }) => {
  const { Wrapper, Info } = Styled;
  return (
    <Wrapper>
      <HeaderFour>
        {label}
        {tip && (
          <Tip overlay={tip} placement="right" capitalize={false}>
            <HelpCircle size="medium" />
          </Tip>
        )}
      </HeaderFour>
      {children}
      <Info error={!!error}>{error || info}</Info>
    </Wrapper>
  );
};

export default FormField;