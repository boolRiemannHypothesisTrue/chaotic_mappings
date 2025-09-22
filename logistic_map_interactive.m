function logistic_map_interactive
    % Интерактивная анимация логистического отображения с слайдером для r
    % Запусти этот файл как функцию: logistic_map_interactive
    
    % параметры
    N = 50;       % количество итераций
    x0 = 0.5;     % начальное значение
    
    % создаём окно
    f = figure('Name','Логистическое отображение','NumberTitle','off','Position',[100 100 800 600]);
    
    % оси для графика
    ax = axes('Parent', f, 'Position',[0.1 0.3 0.85 0.65]);
    hold(ax, 'on'); grid(ax, 'on');
    xlabel(ax, 'x_n');
    ylabel(ax, 'x_{n+1}');
    title(ax, 'Паутинная диаграмма логистического отображения');
    
    % слайдер для параметра r
    uicontrol('Parent', f, 'Style', 'text', 'Position', [150 60 100 20], ...
              'String', 'Значение r', 'BackgroundColor', [0.9 0.9 0.9]);
    slider = uicontrol('Parent', f, 'Style', 'slider', ...
              'Min', 2.5, 'Max', 4, 'Value', 3.7, ...
              'Position', [250 60 400 20], ...
              'Callback', @(src,~) redraw(ax, N, x0, src.Value));
    
    % поле для отображения текущего значения r
    valText = uicontrol('Parent', f, 'Style', 'text', ...
                        'Position', [660 60 100 20], ...
                        'String', ['r = ' num2str(get(slider,'Value'),'%.3f')], ...
                        'BackgroundColor', [0.9 0.9 0.9]);
    
    % начальная отрисовка
    redraw(ax, N, x0, get(slider,'Value'));
    
    % слушатель изменения слайдера
    addlistener(slider,'Value','PostSet',@(src,evt) set(valText,'String',['r = ' num2str(get(slider,'Value'),'%.3f')]));
end

function redraw(ax, N, x0, r)
    % очистка осей
    cla(ax);
    hold(ax, 'on'); grid(ax, 'on');
    
    % диагональ y=x
    fplot(ax, @(x) x, [0 1], 'r--', 'LineWidth', 1.2);
    % функция f(x) = r*x*(1-x)
    fplot(ax, @(x) r*x.*(1-x), [0 1], 'g-', 'LineWidth', 1.2);
    
    % итерации
    x = zeros(1, N);
    x(1) = x0;
    for n = 1:N-1
        x(n+1) = r * x(n) * (1 - x(n));
        
        % рисуем шаги
        plot(ax, [x(n), x(n)], [x(n), x(n+1)], 'b-'); % вертикаль
        plot(ax, [x(n), x(n+1)], [x(n+1), x(n+1)], 'b-'); % горизонталь
        plot(ax, x(n), x(n+1), 'bo', 'MarkerFaceColor','b');
    end
    
    xlabel(ax, 'x_n');
    ylabel(ax, 'x_{n+1}');
    title(ax, ['Паутинная диаграмма при r = ' num2str(r)]);
end
