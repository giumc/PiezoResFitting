function init_param(obj,varargin)

    if ~isempty(varargin)

        if isnumeric(varargin{1})

            obj.set_value(varargin{1},'override');

        else

            for i=1:length(varargin)

                if (ischar(varargin{i})||isstring(varargin{i}))

                    switch varargin{i}

                        case 'value'

                            obj.set_value(varargin{i+1},'override');

                        case 'unit'

                            obj.unit = varargin{i+1};

                        case 'label'

                            obj.label=varargin{i+1};
                            
                        case 'global_max'
                            
                            obj.global_max=varargin{i+1};
                            
                        case 'global_min'
                            
                            obj.global_min=varargin{i+1};

                    end

                end

            end

        end

    end

end
