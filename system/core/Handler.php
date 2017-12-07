<?php

namespace system\core;

abstract class Handler
{
    /**
     * @var null|Handler
     */
    private $successor = null;

    public function __construct(Handler $handler = null)
    {
        $this->successor = $handler;
    }

    /**
     * @param Request $request
     * @return mixed
     */
    final public function handle(Request $request)
    {
        $processed = $this->processing($request);

        if ($processed === null) {

            if ($this->successor !== null) {
                $processed = $this->successor->handle($request);
            }
        }

        return $processed;
    }

    /**
     * @param Request $request
     * @return mixed
     */
    abstract protected function processing(Request $request);
}